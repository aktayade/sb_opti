//===- Hello.cpp - Example code from "Writing an LLVM Pass" ---------------===//
//
//                     The LLVM Compiler Infrastructure
//
// This file is distributed under the University of Illinois Open Source
// License. See LICENSE.TXT for details.
//
//===----------------------------------------------------------------------===//
//
// This file implements two versions of the LLVM "Hello World" pass described
// in docs/WritingAnLLVMPass.html
//
//===----------------------------------------------------------------------===//
//
#define DEBUG_TYPE "hello"
#include <iostream>
#include "llvm/Pass.h"
#include "llvm/Function.h"
#include "llvm/Support/raw_ostream.h"
#include "llvm/ADT/Statistic.h"
#include "llvm/Analysis/ProfileInfo.h"
#include "llvm/ADT/StringRef.h"
#include "llvm/Support/CFG.h"
#include "llvm/Analysis/Trace.h"
#include "LAMP/LAMPLoadProfile.h"
#include "llvm/ADT/ValueMap.h"
#include "llvm/Transforms/Utils/ValueMapper.h"
#include "llvm/Transforms/Utils/Cloning.h"
#include "llvm/Instructions.h"
#include "llvm/Support/IRBuilder.h"
#include "llvm/Analysis/LoopInfo.h"
#include <fstream>
#include<list>
#include<map>
#include<queue>
using namespace llvm;
using namespace std;
typedef std::map<std::pair<Instruction*, Instruction*>*, unsigned int> LampMap;
typedef std::list<BasicBlock *> trace;

namespace{
  struct Hello : public FunctionPass {
    static char ID; // Pass identification, replacement for typeid
    double threshold;
    Hello() : FunctionPass(ID) {}
	ProfileInfo* PI;
	LAMPLoadProfile * LP;
	DominatorTree *DT;
	Function *CurFunc;
	LoopInfo *L;
	virtual bool runOnFunction(Function &F) {
		PI = &getAnalysis<ProfileInfo>();
		DT = &getAnalysis<DominatorTree>();
		CurFunc = &F;
		L = &getAnalysis<LoopInfo>();
		threshold = 60;
		std::list<trace>::iterator itr;
		list<trace> traces = getTraces(threshold);
		writeTracesToFile(traces);
		BasicBlock * side_entrance;
		for (itr = traces.begin(); itr != traces.end(); ++itr) {
			printTrace(*itr);
			side_entrance = getFirstSideEntrance(*itr);
			if(side_entrance != NULL)
			{
				replicateRestOfTrace(*itr,side_entrance);
			}
		}
		//operationMigration(traces);
		loop_unroll(traces);
		CurFunc = NULL;
		errs()<<"Finished\n";
	        return false;
        }
	void writeTracesToFile(list<trace> traces){
		ofstream os;
		os.open("superblocks");
		std::list<trace>::iterator itr;
		bool first;
		for(itr = traces.begin(); itr!=traces.end();itr++){
			first = false;
			
			for(trace::iterator bb = (*itr).begin(); bb != (*itr).end(); bb++){
				const char* bbname = ((*bb)->getName()).data();
				if(!first){
					first = true;
					os<<bbname;
				}
				else
				{
					os <<" ";
					os<<bbname;
				}
			}
			if(hasBackedge(*itr)){
				os << " ";
				os <<"yes";
			}
			else{
				os << " ";
				os << "no";
			}
			os << "\n";
		}
		os.close();
	}
	void loop_unroll(list<trace> traces){
		std::list<trace>::iterator itr;
		for(itr = traces.begin(); itr!= traces.end();++itr){
			if(hasBackedge(*itr)){
				errs()<< "trace with backedge -\n";
				printTrace(*itr);
				unroll(*itr,2);
//				induction_variable(*itr,2);
			}
		}
	}
	void induction_variable(trace t,int unroll_count){
		BasicBlock* first = *(t.begin());
		BasicBlock* p = L->getLoopFor(first)->getLoopPreheader();
		errs()<<"induction variable = "<<(Value*)(L->getLoopFor(first)->getCanonicalInductionVariable())<<"\n";
		Value *induc_var, *label, *initialVal, *increment;
		BasicBlock::iterator temp = (first)->end();
		temp--;
		if((temp->getOpcode() >= 1 && temp->getOpcode() <= 7) || (temp->getOpcode()>=26 && temp->getOpcode()<=32) || temp->getOpcode() == 48) {
                	label = temp->getOperand(0);
                } else {
			errs() << "No Branch in first for.cond\n";
		}
		// Goto the branch instruction
		for(BasicBlock::iterator II = first->begin();II!=first->end();II++){
			if((Value*)II == label){
				induc_var = II->getOperand(0);
			}
		}
		
		
		// Goto the corresponding Phi.
		for(BasicBlock::iterator II = first->begin();II!=first->end();II++){
			if(isa<PHINode>(*II) && (induc_var == (Value*)II))
                        {
				Instruction *U = II;
                                PHINode *PN = dyn_cast<PHINode>(U);
				for(unsigned int i = 0; i < PN->getNumIncomingValues(); i++) {
					if(PN->getIncomingBlock(i) ==  (BasicBlock *) p) {
						initialVal = PN->getIncomingValue(i);
					}
				}	
                        }
                }

		// Get the increment val
		for(trace::iterator i = t.begin(); i != t.end(); i++) {
			string block_name = (std::string)(*i)->getName();
			if(block_name.find("for.inc") != std::string::npos ){
				for (BasicBlock::iterator II = (*i)->begin(); II != (*i)->end(); II++) {
					for(unsigned int j = 0; j < II->getNumOperands(); j++){
						if(II->getOperand(j) == induc_var){
							if(j == 1) {
								increment = II->getOperand(0);
							} else {
								increment = II->getOperand(1);
							}
						}
					}
				}
			}
		}
		errs() << "The induction variable is: " << (*induc_var) << "\n";
		errs() << "The initial value: " << (*initialVal) << "\n";
		errs() << "The increment is: " << (*increment) << "\n";
	}
	void unroll(trace t,int unroll_count){
		std::map<BasicBlock*,BasicBlock*> clone_map;
                std::map<const Value*, WeakVH> global_vtovmap;
		BasicBlock* copy;
		TerminatorInst * term;
		for(trace::iterator itr = t.begin();itr!=t.end();itr++){
			ValueToValueMapTy vtovmap;
                        copy = CloneBasicBlock(*itr,vtovmap,"_copy",CurFunc);
                        for(ValueToValueMapTy::iterator i = vtovmap.begin(); i != vtovmap.end(); i++ )
                        {
                                global_vtovmap.insert(make_pair(i->first,i->second));
                        }
			clone_map.insert(make_pair(*itr,copy));

			Value* rhs;
                        for (BasicBlock::iterator II = copy->begin(), ie = copy->end(); II != ie; ++II) {
                                for(unsigned int i=0;i<II->getNumOperands();i++)
                                {
                                        if(vtovmap.find(II->getOperand(i)) != vtovmap.end())
                                        {
                                                rhs = vtovmap[II->getOperand(i)];
                                                II->setOperand(i,rhs);
                                        }
                                }
                        }				
		}
		errs()<<"Cloned\n";
		for(trace::iterator itr = t.begin();itr!=t.end();itr++){
			copy = clone_map[*itr];
			term = copy->getTerminator();
			for(unsigned int i=0;i<term->getNumSuccessors();i++){
				if(find(t.begin(),t.end(),term->getSuccessor(i))!= t.end()){
					term->setSuccessor(i,clone_map[term->getSuccessor(i)]);	
				}
			}	
		}
		//remove backedge and point it to copy of for.cond
		trace::iterator tmp = t.end();
		tmp--;
		BasicBlock* last = *(tmp);
		term = last->getTerminator();
		for(unsigned int i =0;i<term->getNumSuccessors();i++){
			if(term->getSuccessor(i) == *(t.begin())){
				term->setSuccessor(i,clone_map[*(t.begin())]);
			}
		}
		copy = clone_map[last];
		term = copy->getTerminator();
		for(unsigned int i =0;i<term->getNumSuccessors();i++){
                        if(term->getSuccessor(i) == clone_map[*(t.begin())]){
                                term->setSuccessor(i,*(t.begin()));
                        }
                }
		
	}

	bool hasBackedge(trace t){
		trace::iterator tmp = t.end();
		tmp--;
		BasicBlock* last = *(tmp);
		errs()<<"last basic block - "<<last->getName()<<"\n";
		for(succ_iterator succ = succ_begin(last);succ != succ_end(last);succ++){
			if(*succ == *(t.begin()))
				return true;
		}
		return false;
	}
	void operationMigration(list<trace> traces){
		std::list<trace>::iterator itr;
		for (itr = traces.begin(); itr != traces.end(); ++itr) {
                 	errs()<<"===============================================================================\n";
        	        printTrace(*itr);
                	if((*itr).size() == 1)
                        	continue;
			migrate(*itr);
		}
	}
	void migrate(trace t){
		trace::iterator itr = t.begin();
		Value* lhs;
		bool inside_trace = false;
		for(itr = t.begin();itr != t.end();itr++){
			for(BasicBlock::iterator II = (*itr)->begin();II!=(*itr)->end();II++){
				errs() << "Opcode = " << II->getOpcode() << "\n";
		                if((II->getOpcode() >= 1 && II->getOpcode() <= 7) || (II->getOpcode()>=26 && II->getOpcode()<=32) || II->getOpcode() == 48)
					continue;
				lhs = (Value*)II;
				errs() << "Value of lhs: " << lhs->getName() << "\n";
				inside_trace = false;
				for (Value::use_iterator i = lhs->use_begin(), e = lhs->use_end(); i != e; ++i){
					if (Instruction *Inst = dyn_cast<Instruction>(*i)) {
						if(find(t.begin(),t.end(),Inst->getParent()) != t.end()){
							inside_trace = true;
							errs() << *II << "\t used somewhere in the sb. Opcode = " << II->getOpcode()  <<"\n";
							break;
						}
					}
				}
				if(inside_trace == false){
					//II can be migrated
					errs() << *II << " Operation found of migration. Parent is "<<II->getParent()<<"\n";
					moveOut(&(*II),t);
			                errs()<<"Moveout done\n";
                    			return;
			                //break;
				}
	                	errs()<<"inner for\n";
			}
		}
	        errs()<<"Migrate done for trace\n";
	}
	void moveOut(Instruction* II, trace t){
		list<BasicBlock*>::iterator temp = t.end();
        	--temp;
	        BasicBlock* last_bb = *(temp);
		list<BasicBlock*> successors;
		Value* lhs = (Value*)II;
		errs() << lhs->getName() << " is the LHS.\n";
		
		
        	unsigned int i;
		// added on 7-12
		trace::iterator itr = t.begin();
		while(*itr != II->getParent()){
			itr++;
		}
		for(;*itr!=last_bb;itr++){
			for(succ_iterator succ = succ_begin(*itr); succ != succ_end(*itr); succ++){
				if(find(t.begin(),t.end(),*succ) == t.end()){
					errs()<<"side exit added : "<<(*succ)->getName()<<"\n";
					successors.push_back(*succ);
				}
			}
		}
		// done
	        errs() << "Last BB = " << last_bb->getName() << "\n";
		for(succ_iterator succ = succ_begin(last_bb);succ != succ_end(last_bb);succ++){
			errs() << "Successor = " << succ->getName() << "\n";
		        if(find(t.begin(),t.end(),*succ)!=t.end()){
	                	bool phi_node_found = false;
				for(BasicBlock::iterator succII = (*succ)->begin();succII!=(*succ)->end();succII++){
					errs() << succII->getName() << "\n";
        			        if(isa<PHINode>(*succII))
                    			{
                        			Instruction *U = succII;
		                                PHINode *PN = dyn_cast<PHINode>(U);
						for(i = 0; i < PN->getNumIncomingValues (); i++){
							if(lhs == PN->getIncomingValue(i)){
				                                phi_node_found = true;
								successors.push_back(*succ);
								break;
							}
						}
					}
				}
		                if(!phi_node_found){
        	            		errs() << "No Phi node found\n";
                	   		for(succ_iterator succ_succ = succ_begin(*succ);succ_succ != succ_end(*succ);succ_succ++){
				                if(find(t.begin(),t.end(),*succ_succ) == t.end()){
                           				errs() << (*succ_succ)->getName() << " is the successors successor \n";
			                	        successors.push_back(*succ_succ);
                       				}
                   			}
                	 	}
			}
			else { 
				successors.push_back(*succ);
			}
		}
	        errs() << "Successors list done.\n";
		std::map<BasicBlock*,list<Value*> > in_set;
		std::map<BasicBlock*, Value*> clone_inst;
		std::list<BasicBlock*> visited;
		lhs = (Value*)II;
        	IRBuilder<> build_ir(II->getParent());
		for(list<BasicBlock*>::iterator itr = successors.begin();itr!=successors.end();itr++){
			errs() << "Current successor = " << (*itr)->getName() << "\n";
		        Instruction* clone = II->clone();
			errs() << "Instr to migrate: " << (*itr) << "\n";
			//clone->insertBefore((*itr)->begin());
			clone->insertBefore((*itr)->getFirstNonPHI());
		        errs()<<"clone inst before insert = "<< *clone << "\n";
		        clone_inst.insert(make_pair(*itr,(Value*)clone));
		        errs()<<"clone inst after insert = "<< *clone << "\n";
		        Value* clone_lhs = (Value*)clone;
		        errs()<<"Value * of II = " << ((Value*)II)->getName() << "\t Value * of clone = "<<clone_lhs<<"\n";
		        errs() << "Clone: " << *((Value*)clone) << " map entry:" << clone_inst[*itr]->getName() << "\n";
		        errs() << *clone << " inserted in basic block "<<clone->getParent()->getName()<<"\n";
		        // Rename
			for(BasicBlock::iterator i=(*itr)->begin(); i != (*itr)->end(); i++) {
        		        if(isa<PHINode>(*i))
	                	{
			                Instruction *U = i;
	                		PHINode *PN = dyn_cast<PHINode>(U);
					for(unsigned int j = 0; j < PN->getNumIncomingValues(); j++){
						if(PN->getIncomingValue(j) == lhs){
							PN->setIncomingValue(j,clone_inst[*itr]);
							PN->setIncomingBlock(j,*itr);
						}
					}
		               } 
			       else {
					for(unsigned int p = 0; p < i->getNumOperands() ; p++){
			                       	if(i->getOperand(p) == lhs){
                        				i->setOperand(p,clone_inst[*itr]);
	                    			}
        	        		}
				}
            		}
        	}
	        errs() << "all instructions moved.\n";
        	BasicBlock* parent = II->getParent();
		// Delete done after renaming.
	        //II->eraseFromParent();
        	errs()<<"parent of II = "<<parent->getName()<<"\n";
	        for(BasicBlock::iterator instr = parent->begin();instr != parent->end();instr++){
        		errs()<<"instr = "<<*instr<<"\n";
        	}
	        errs() << "original instruction removed. Mow starting BFS for propogating.\n";
		for(list<BasicBlock*>::iterator itr = successors.begin();itr!=successors.end();itr++){
			std::queue<BasicBlock*> q;
			visited.push_back(*itr);
			q.push(*itr);
            		Value* current_alias = clone_inst[*itr];
		        errs() << "Current Alias = " << current_alias->getName() << "\n";
		        while(!q.empty()){
				BasicBlock* current_block = q.front();
				q.pop();
				visited.push_back(current_block);
				for(BasicBlock::iterator i=current_block->begin(); i != current_block->end(); i++) {
			                if(isa<PHINode>(*i)){
                        			Instruction *U = i;
			                        PHINode *PN = dyn_cast<PHINode>(U);
                        			for(unsigned int j = 0; j < PN->getNumIncomingValues(); j++) {
			         	        	if(PN->getIncomingValue(j) == lhs){
				                                PN->setIncomingValue(j,clone_inst[*itr]);
                                				PN->setIncomingBlock(j,*itr);
                            				}
                        			}
				        } 
					else {
			                        for(unsigned int p = 0; p < i->getNumOperands() ; p++){
                        				if(i->getOperand(p) == lhs){
				                                errs() << "NOT PRINTED";
                                				i->setOperand(p,current_alias);
                            				}
                        			}
                    			}	
					for(succ_iterator succ = succ_begin(current_block); succ != succ_end(current_block); succ++){
						if(find(visited.begin(),visited.end(),*succ) == visited.end()){
							q.push(*succ);
						}
					}
				}
			}
		}
	        II->eraseFromParent();
        	errs() << "Finished on our part!\n";
	}
	
	void printTrace(trace t)
	{
		errs()<<"Printing trace\n";
		for(trace::iterator itr = t.begin();itr!=t.end();itr++)
                {
                        errs()<<"trace BB = "<<(*itr)->getName()<<"\n";
                }
	}
	bool isPresentInTrace(trace t,BasicBlock* bb)
	{
		for(trace::iterator itr = t.begin();itr!=t.end();itr++)
		{
			if((*itr)->getName() == bb->getName())
				return true;
		}
		return false;
	}
	void replicateRestOfTrace(trace t, BasicBlock* side_entrance_block)
	{
		std::list<BasicBlock*>::iterator itr = t.begin();
		
		std::map<BasicBlock*,BasicBlock*> clone_map;
	        std::map<const Value*, WeakVH> global_vtovmap; 
		BasicBlock* term_succ;
		TerminatorInst * term;
		while(*itr != side_entrance_block)
			itr++;
		BasicBlock *copy,*copy_src;
	        for (;itr != t.end(); ++itr) {
			ValueToValueMapTy vtovmap;
			copy = CloneBasicBlock(*itr,vtovmap,"_copy",CurFunc);
			for(ValueToValueMapTy::iterator i = vtovmap.begin(); i != vtovmap.end(); i++ )
            		{
		                global_vtovmap.insert(make_pair(i->first,i->second));
            		}
			//errs()<<"copy BB name - "<<copy->getName();
			Value* rhs;
			for (BasicBlock::iterator II = copy->begin(), ie = copy->end(); II != ie; ++II) {
				for(unsigned int i=0;i<II->getNumOperands();i++)
                        	{
                                	if(vtovmap.find(II->getOperand(i)) != vtovmap.end())
                                	{
						rhs = vtovmap[II->getOperand(i)];
						II->setOperand(i,rhs);
                	                }
                        	}	
			}
			clone_map.insert(make_pair(*itr,copy));
		}
		//errs()<<"Cloned\n";

		//when there is a Phi node in the side entrance block, the Phi may have to be removed if one of its operand is from the basic block that is the side entrance. This is done as follows - Check whether each instruction in the side entrance block is Phi using isa<PHINode>(inst). If it is a PHI instruction, for each of its operands, get their use def chains. If the def is from the BB that is the side entrance, then delete this PHI instruction. The lhs of the PHI instruction must be assigned the other operand of the PHI node if the other operand is from a BB in the trace. The same procedure has to be done for the clone of the side entrance block as well.
		list<PHINode*> phi_inst;
		for (BasicBlock::iterator II = side_entrance_block->begin(), ie = side_entrance_block->end(); II != ie; ++II) {
			if(isa<PHINode>(*II))
			{
		//		errs()<<"*******************************Phi node found********************************\n";
				Instruction *U = II;
				PHINode *PN = dyn_cast<PHINode>(U);
				phi_inst.push_back(PN);
			}
		}
		
		for(pred_iterator itr=pred_begin(side_entrance_block);itr != pred_end(side_entrance_block); itr++)
		{
			if(isPresentInTrace(t,*itr))
			{
				//errs()<<"BB found in Trace\n";
				continue;
			}
			//if(find(t.begin(),t.end(),*itr) != t.end())
				//continue;
			for(list<PHINode*>::iterator I=phi_inst.begin();I != phi_inst.end();I++)
				(*I)->removeIncomingValue(*itr);
			//errs()<<"Basic block - "<<(*itr)->getName()<<"\n";
			term = (*itr)->getTerminator();
			//errs()<<"num successors = "<<term->getNumSuccessors()<<"\n";
			for(unsigned int i=0; i < term->getNumSuccessors(); i++)
			{
				term_succ = term->getSuccessor(i);
				if(term_succ == side_entrance_block)
				{
					term->setSuccessor(i,clone_map[side_entrance_block]);
				}
				else
				{
				}
			}
		}
		// Do the above thing for the clone of side entrance block
		for (BasicBlock::iterator II = clone_map[side_entrance_block]->begin(), ie = clone_map[side_entrance_block]->end(); II != ie; ++II) {
                        if(isa<PHINode>(*II))
                        {
                                Instruction *U = II;
                                PHINode *PN = dyn_cast<PHINode>(U);
				for(unsigned int i=0;i< PN->getNumIncomingValues();i++){
					if(find(pred_begin(clone_map[side_entrance_block]),pred_end(clone_map[side_entrance_block]),PN->getIncomingBlock(i)) == pred_end(clone_map[side_entrance_block]))
						PN->removeIncomingValue(PN->getIncomingBlock(i));
				}
                        }
                }
		//This part needs debugging. Let X' be the copy of X and Y be a successor of X and Y' be the copy of Y. When we change the successors of the node X' from Y to Y', if there is any PHI node in BB Y', its operand BB should be changed from X to X'.
		errs()<<"----\n";
		itr = t.begin();
		while(*itr != side_entrance_block)
			itr++;
	        for (;itr != t.end(); ++itr) {
			if(find(t.begin(),t.end(),*itr) == t.end())
                	{
	        	        copy_src = *itr;
		        }
        	   	else
			{
                		copy_src = clone_map[*itr];
    				term = copy_src->getTerminator();
	                	for(unsigned int i=0; i < term->getNumSuccessors(); i++)
           	        	{
               	        		term_succ = term->getSuccessor(i);
				    	if(find(t.begin(),t.end(),term_succ) == t.end() || (clone_map.find(term_succ) == clone_map.end()))
					    	continue;
		                        term->setSuccessor(i,clone_map[term_succ]);
                		        for (BasicBlock::iterator II = clone_map[term_succ]->begin(), ie = clone_map[term_succ]->end(); II != ie; ++II)
                        		{
		                        	for(unsigned int i=0;i<II->getNumOperands();i++)
                            			{
		                                	if(global_vtovmap.find(II->getOperand(i)) != global_vtovmap.end())
                		                	{
                                				Value* rhs = global_vtovmap[II->getOperand(i)];
        	                            			II->setOperand(i,rhs);
                	                		}
                        	    		}
                        		}
		                        for (BasicBlock::iterator II = clone_map[term_succ]->begin(), ie = clone_map[term_succ]->end(); II != ie; ++II)
        		                {
                        			if(isa<PHINode>(*II)){
		                	                Instruction *U = II;
                		        	        PHINode *PN = dyn_cast<PHINode>(U);
                                			for(unsigned int i=0;i< PN->getNumIncomingValues();i++){
			                                	if(PN->getIncomingBlock(i) == *itr){
		                        		                PN->setIncomingBlock(i,copy_src);
                		                    		}
                                			}
                            			}
               	        		}
                    		}
                	}
		}
		itr = t.begin();
		while(*itr != side_entrance_block)
                        itr++;
		for(;itr != t.end();itr++){
			for(pred_iterator p = pred_begin(*itr);p != pred_end(*itr); p++){
				if(find(t.begin(),t.end(),*p) == t.end()){
					term = (*p)->getTerminator();
					for(unsigned int i=0;i<term->getNumSuccessors();i++){
						term_succ = term->getSuccessor(i);
						if(term_succ == *itr){
							term->setSuccessor(i,clone_map[*itr]);
							for (BasicBlock::iterator II = (*itr)->begin(), ie = (*itr)->end(); II != ie; ++II)
		                                        {
                		                        	if(isa<PHINode>(*II)){
		                                                        Instruction *U = II;
                		                                        PHINode *PN = dyn_cast<PHINode>(U);
                                		                        for(unsigned int i=0;i< PN->getNumIncomingValues();i++){
                                                		                if(PN->getIncomingBlock(i) == *p){
                                                                		        PN->removeIncomingValue(i);
                                                                		}
                                                        		}
								}
							}
						}
					}
				}
			}
		}
	}
	
	BasicBlock* getFirstSideEntrance(trace t)
	{
		//errs()<<"Inside Get First side entrance\n";
		bool first = false;
		std::list<BasicBlock*>::iterator itr;
		std::list<BasicBlock*>::iterator itr2;
	        for (itr = t.begin(); itr != t.end(); ++itr) {
			if(!first)
			{
				//errs()<<"First bb of trace = "<<(*itr)->getName()<<"\n";
				first = true;
				continue;
			}
			for (pred_iterator PI = pred_begin(*itr), E = pred_end(*itr); PI != E; ++PI) {
				BasicBlock *Pred = *PI;
				//errs()<<"Checking current BB = "<<Pred->getName()<<"\n";
				for (itr2 = t.begin(); itr2 != t.end(); ++itr2) {
					if(*itr2 == Pred)
					{
						//errs()<<"BB found in trace\n";
						break;
					}
				}
				if(itr2 == t.end())
					return *itr;
			}
		}
		return NULL;
	}	

	list<trace> getTraces(double threshold)
	{
		std::map<BasicBlock*,bool> visited;
		//initialize map with all BB set to false
		for(Function::iterator b = CurFunc->begin(), be = CurFunc->end();b!=be;++b){
			visited.insert(std::pair<BasicBlock*,bool>(b,false));
		}
		list<trace> traces;
		BasicBlock* seed;
		BasicBlock* current;
		BasicBlock* next;
		BasicBlock* prev;
		while(!all_visited(visited))
		{
			trace curTrace;
			seed = getMostVisited(visited);
			if(seed == NULL)
				break;
			//errs()<<"seed = "<<seed->getName()<<"\n";
			curTrace.push_back(seed);
			if(visited.find(seed) != visited.end())
				visited.erase(visited.find(seed));
			visited.insert(std::pair<BasicBlock*,bool>(seed,true));
			current =seed;
			while(true)
			{
				next = best_successor(current,threshold,visited);
				if(next == NULL)
				{
					//errs()<<"Next = NULL\n";
					break;
				}
				//errs()<<"Next = "<<next->getName()<<"\n";
				curTrace.push_back(next);
				if(visited.find(next) != visited.end())
					visited.erase(visited.find(next));
				visited.insert(std::pair<BasicBlock*,bool>(next,true));
/*				if(curTrace.size() == 3)
                    			break;
*/
				current = next;
			}
			current = seed;
			while(true){   
/*
	                	if(curTrace.size() == 3)
	        	            break;
*/
  		          	prev = best_predecessor(current,threshold,visited);
	        	        if(prev == NULL){
					//errs()<<"Prev = NULL\n";
                                	break;
				}
		                curTrace.push_front(prev);
        	        	//errs()<<"Prev = "<<prev->getName()<<"\n";
				if(visited.find(prev) != visited.end())
	                		visited.erase(visited.find(prev));
	                        visited.insert(std::pair<BasicBlock*,bool>(prev,true));
        	                current = prev;
            		}
			traces.push_back(curTrace);
		}
		//errs()<<"Finished get traces\n";
		return traces;
	}
	BasicBlock* getMostVisited(map<BasicBlock*,bool> visited)
	{
		int max = -1;
		BasicBlock * seed = NULL;
		//errs()<<"Inside get most visited...\n";
		for (map<BasicBlock*,bool>::iterator iter = visited.begin(); iter != visited.end(); iter++){
			//errs()<<"bb = "<<(iter->first)->getName()<<"\tvisited = "<<iter->second<<"\n";
			if(iter->second == true)
				continue;
			//errs()<<"Execution count = "<<PI->getExecutionCount(iter->first)<<"\n";
			if(PI->getExecutionCount(iter->first) > max){
				max = PI->getExecutionCount(iter->first);
				seed = iter->first;
			}
		}
		//errs()<<"Finished get most visited\n";
		return seed;
	}
	bool all_visited(map<BasicBlock*,bool> visited)
	{
		for (map<BasicBlock*,bool>::iterator iter = visited.begin(); iter != visited.end(); iter++) {
			if(iter->second == false)
				return false;
		}
		return true;
	}
	BasicBlock* best_successor(BasicBlock* source,double threshold,map<BasicBlock*,bool> visited)
	{
		double total_weight = 0;
                double max_weight = 0;
		BasicBlock* max_succ=NULL;
		double edge_weight,bias_percent;
//		if(b->getTerminator()->getNumSuccessors() <= 1)
//                        continue;
                int exec_count = PI->getExecutionCount(source);
                if (exec_count <= 0)
		{
                        return NULL;
		}
                for (succ_iterator S = succ_begin(source), E = succ_end(source); S != E; ++S) {
                        BasicBlock *dest = *S;
			//errs()<<"Successor = "<<dest->getName()<<"\n";
                        edge_weight = PI->getEdgeWeight(PI->getEdge(source,dest));
                        if(edge_weight == -1)
                                continue;
                        else if(max_weight < edge_weight)
			{
                                max_weight = edge_weight;
				max_succ = dest;
			}
                        total_weight += edge_weight;
                }
		if(total_weight == 0)
		{
			return NULL;
		}
		else
		{
			bias_percent = (max_weight/total_weight)*100;
			if(bias_percent < threshold || visited[max_succ] || DT->dominates(max_succ,source))
			{
				return NULL;
			}
			else
			{
				return max_succ;
			}
		}
	}
	BasicBlock* best_predecessor(BasicBlock* source,double threshold,map<BasicBlock*,bool> visited)
        {
                double total_weight = 0;
                double max_weight = 0;
		double edge_weight,bias_percent;
                BasicBlock* max_pred=NULL;
		int exec_count = PI->getExecutionCount(source);
                if (exec_count <= 0)
		{
                        return NULL;
		}
                for (pred_iterator S = pred_begin(source), E = pred_end(source); S != E; ++S) {
                        BasicBlock *dest = *S;
			//errs()<<"Predecessor = "<<dest->getName()<<"\n";
                        edge_weight = PI->getEdgeWeight(PI->getEdge(dest,source));
                        if(edge_weight == -1)
                                continue;
                        else if(max_weight < edge_weight)
                        {
                                max_weight = edge_weight;
                                max_pred = dest;
                        }
                        total_weight += edge_weight;
                }
                if(total_weight == 0)
		{
                        return NULL;
		}
                else
                {
                        bias_percent = (max_weight/total_weight)*100;
                        if(bias_percent < threshold || visited[max_pred] ||  DT->dominates(source,max_pred))
			{
                                return NULL;
			}
                        else
			{
                                return max_pred;
			}
                }
        }

	void getAnalysisUsage(AnalysisUsage &AU) const {
		AU.addRequired<ProfileInfo>();
		AU.addRequired<LAMPLoadProfile>();
		AU.setPreservesCFG();
	        AU.addRequired<DominatorTree>();
		AU.addRequired<LoopInfo>();
	}
  };
}

char Hello::ID = 0;
static RegisterPass<Hello> X("hello", "Hello World Pass");
