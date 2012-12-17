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
#define DEBUG_TYPE "indvar"
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
#include <math.h>
using namespace llvm;
using namespace std;
//STATISTIC(HelloCounter, "Counts number of functions greeted");
typedef std::map<std::pair<Instruction*, Instruction*>*, unsigned int> LampMap;
typedef std::list<BasicBlock *> trace;

namespace{
  // Hello - The first implementation, without getAnalysisUsage.
  struct IndVar : public FunctionPass {
    static char ID; // Pass identification, replacement for typeid
    double threshold;
    IndVar() : FunctionPass(ID) {}
	ProfileInfo* PI;
	LAMPLoadProfile * LP;
	DominatorTree *DT;
	Function *CurFunc;
	LoopInfo *L;
	std::map<trace,bool> backedge;
	virtual bool runOnFunction(Function &F) {
		//errs() <<"Running pass...\n";
		PI = &getAnalysis<ProfileInfo>();
		DT = &getAnalysis<DominatorTree>();
		CurFunc = &F;
		L = &getAnalysis<LoopInfo>();
		//errs()<<"Current function = "<<F.getName()<<"\n";
		threshold = 60;
		//errs()<<"getting traces...\n";
		std::list<trace>::iterator itr;
		list<trace> traces;
		traces = readTracesFromFile();
		BasicBlock* side_entrance;
		for (itr = traces.begin(); itr != traces.end(); ++itr) {
			printTrace(*itr);
		}

	//	errs()<<"Starting induction variable optimization\n";
		for (itr = traces.begin(); itr != traces.end(); ++itr) {
			if(backedge[*itr]){
				errs()<<"Current trace : \n";
		        	printTrace(*itr);
				induction_variable(*itr,3);
			}
                }
		CurFunc = NULL;
	//	errs()<<"Finished\n";
	        return false;
        }
	list<trace> readTracesFromFile(){
		ifstream is ("superblocks");
		string line,word;
		list<trace> traces;
		string function_name;
		if(is.is_open()){
			while(is.good()){
				getline(is,line);
				int pos = 0;
	//			errs()<<"line = "<<line<<"\n";
				if(line.size() == 0){
					break;
				}
				trace t;

				if(line.find("Function") != std::string::npos ){
                                        function_name = line.substr(9,line.size());
                                        continue;
                                }
                                if(function_name != CurFunc->getName()){
                                        continue;
                                }

				while(line.find(" ",pos) != -1){
					int end = line.find(" ",pos);
	//				errs()<< end <<"\t"<<pos<<"\n";	
					word = line.substr(pos,end-pos);
	//				errs()<<"word = "<<word<<"\n";
					pos = end+1;
					for (Function::iterator BB = CurFunc->begin(), e = CurFunc->end(); BB != e; ++BB){
						if(word.compare((BB->getName()).data()) == 0){
							t.push_back(&(*BB));
						}
					}
				}
				word = line.substr(pos,line.size()-pos);
	//			errs()<<"word = "<<word<<"\n";
				if(word.compare("yes")==0){
					backedge.insert(make_pair(t,true));
				}
				else{
					backedge.insert(make_pair(t,false));
				}
				traces.push_back(t);
	//			errs()<<"done\n";
			}
		}
		return traces;
	}
	
	void induction_variable(trace t,int unroll_count){
		if(unroll_count == 0)
			return;
		unroll_count = (int)pow(2,unroll_count);
		BasicBlock* first = *(t.begin());
		BasicBlock* p = L->getLoopFor(first)->getLoopPreheader();
	//	errs()<<"induction variable = "<<(Value*)(L->getLoopFor(first)->getCanonicalInductionVariable())<<"\n";
		Value *induc_var, *label, *initialVal, *increment;
		BasicBlock::iterator temp = (first)->end();
		int increment_opcode = -1;
		Instruction* induction_inst;
		temp--;
		if((temp->getOpcode() >= 1 && temp->getOpcode() <= 7) || (temp->getOpcode()>=26 && temp->getOpcode()<=32) || temp->getOpcode() == 48) {
                	label = temp->getOperand(0);
                } else {
	//		errs() << "No Branch in first for.cond\n";
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
						induction_inst = II;
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
								increment_opcode = II->getOpcode();
										
							} else {
								increment = II->getOperand(1);
								increment_opcode = II->getOpcode();
							}
						}
					}
				}
			}
		}
	
	//	errs() << "The induction variable is: " << (*induc_var) << "\n";
	//	errs() << "The initial value: " << (*initialVal) << "\n";
	//	errs() << "The increment is: " << (*increment) << "\n";
		
		IRBuilder<> build_ir(p);
		BasicBlock::iterator preheader_end = p->end();
        Instruction * secondLast = --preheader_end;
        build_ir.SetInsertPoint(secondLast);
		std::map<int,AllocaInst*> induction_map;
        AllocaInst * ainst = build_ir.CreateAlloca(induc_var->getType(),0,"induction");
        //errs() << "The increment is: " << (*increment) << "\n";
        build_ir.CreateStore(initialVal, ainst);
		induction_map.insert(make_pair(0,ainst));
		llvm::ConstantInt* CI = dyn_cast<llvm::ConstantInt>(initialVal);
		int init_value = CI->getSExtValue();
		llvm::ConstantInt* CInc = dyn_cast<llvm::ConstantInt>(increment);
        int inc = CInc->getSExtValue();
        int ind_initval=init_value;
        int ind_incr;
	//	errs()<<"initial = "<<init_value<<"\tinc="<<inc<<"opcode = "<<increment_opcode<<"\n";
		for(int i = 1;i<unroll_count;i++){
			if(increment_opcode == 8 || increment_opcode == 9){
				ind_initval = ind_initval+inc;
                ind_incr = inc*unroll_count; 
			}
			else if(increment_opcode == 10 || increment_opcode == 11){
				ind_initval = ind_initval-inc;
                ind_incr = inc*unroll_count;
			}
			else if(increment_opcode == 12 || increment_opcode == 13){
				ind_initval = ind_initval * inc;
                ind_incr = (int)pow(inc,unroll_count);
			}
			ainst = build_ir.CreateAlloca(induc_var->getType(),0,"induction");
	        build_ir.CreateStore(ConstantInt::getSigned(Type::getInt32Ty(getGlobalContext()),ind_initval), ainst);
			induction_map.insert(make_pair(i,ainst));
		}
	    
		first = *(t.begin());
		build_ir.SetInsertPoint(first->getFirstNonPHI());
        	LoadInst* ld = build_ir.CreateLoad((Value*)induction_map[0]);
		std::map<Value*,Value*> orig_induction;
		orig_induction.insert(make_pair(induc_var,(Value*)ld));
		
		Value *lhs = (Value*)ld;
		std::map<int,Value*> unroll_var;
		std::map<Value*,int> unroll_var_inverse;
        std::map<Value*,BasicBlock*> rename_BB_map;
		for(Function::iterator BB = CurFunc->begin(); BB != CurFunc->end();BB++){
			for(BasicBlock::iterator II = BB->begin(); II != BB->end(); II++){
	//			errs()<<"loop starting!\n";
				if(isa<PHINode>(*II)){
					Instruction *U = II;
                	PHINode *PN = dyn_cast<PHINode>(U);
					for(int op = 0; op < PN->getNumIncomingValues(); op++){
						if(PN->getIncomingValue(op) == induc_var){
	//						errs()<<"replacing op in phi node\n";
							BasicBlock* tmp = PN->getIncomingBlock(op);
							PN->removeIncomingValue(op);
							PN->addIncoming(lhs,tmp);
	//						errs()<<"Instruction = "<<*II<<"\n";
						}
					}
				}
				else {
					for(int op = 0; op<II->getNumOperands(); op++){
						if(II->getOperand(op) == induc_var){
							II->setOperand(op,lhs);
	//						errs()<<"operand set\n";
	//						errs()<<"Instruction = "<<*II<<"\n";
							string block_name = (std::string)(BB)->getName();
				            if(block_name.find("for.inc") != std::string::npos ){
								unroll_var.insert(make_pair(0,(Value*)II));
								unroll_var_inverse.insert(make_pair((Value*)II,0));

								BasicBlock::iterator preheader_end = BB->end();
		    			        Instruction * secondLast = --preheader_end;
						        build_ir.SetInsertPoint(secondLast);
								build_ir.CreateStore((Value*)II, induction_map[0]);
							}
						}
					}
				}
			}
		}
		induction_inst->eraseFromParent();
		std::map<Value*,Value*> renaming_map;
            
		for(Function::iterator BB = CurFunc->begin(); BB != CurFunc->end();BB++){
			string block_name = (std::string)(BB->getName());	
			if(block_name.find("for.inc") != std::string::npos){
				for(BasicBlock::iterator II = BB->begin(); II != BB->end(); II++){
					Value *rhs = II->getOperand(0);
					
					if(find(t.begin(),t.end(),BB) != t.end()){
					    // If in trace, skip.
                    }
					else{
						int u = unroll_var_inverse[rhs];
						BasicBlock::iterator preheader_end = BB->end();
                        Instruction * secondLast = --preheader_end;
                        build_ir.SetInsertPoint(secondLast);
                        build_ir.CreateStore((Value*)II, induction_map[u+1]);
						unroll_var.insert(make_pair(u+1,(Value*)II));
                        unroll_var_inverse.insert(make_pair((Value*)II,u+1));
					}
					break;
                }
                Instruction* first_instr = BB->begin();
                first_instr->setOperand(first_instr->getNumOperands()-1, ConstantInt::getSigned(Type::getInt32Ty(getGlobalContext()),ind_incr));
			}
			else if(block_name.find("for.cond") != std::string::npos){
				if(find(t.begin(),t.end(),BB) != t.end()){
                    // If in trace, skip.
                }
				else{
					BasicBlock::iterator preheader_end = BB->end();
	                Instruction * secondLast = --preheader_end;
					Instruction * thirdLast = --preheader_end;
	//				errs()<<"secondlast = "<<*thirdLast<<"\n";	
					Value *rhs = thirdLast->getOperand(0);
					int u = unroll_var_inverse[rhs];
          //          errs() << "Current Unroll#: " << u <<"\n";
            //        errs() << "Current RHS#: " << *rhs <<"\n";
					build_ir.SetInsertPoint(BB->getFirstNonPHI());
	//	            errs() << "Inserting Load: " << (*(Value*)induction_map[u+1])<<"\n";
                    LoadInst* l = build_ir.CreateLoad((Value*)induction_map[u+1]);
	//				errs()<<"key = "<<*rhs<<"\tvalue = "<<*((Value*)l)<<"\n";
					renaming_map.insert(make_pair(rhs,(Value*)l));
                    rename_BB_map.insert(make_pair((Value*)l, thirdLast->getParent()));
          //          errs()<<",,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,\n";
				}
			}
		}
         
		for(Function::iterator BB = CurFunc->begin(); BB != CurFunc->end();BB++){
                        for(BasicBlock::iterator II = BB->begin(); II != BB->end(); II++){
                                if(isa<PHINode>(*II)){
                                        Instruction *U = II;
                                        PHINode *PN = dyn_cast<PHINode>(U);
                                        for(int op = 0; op < PN->getNumIncomingValues(); op++){
                                                if(renaming_map.find(PN->getIncomingValue(op))!= renaming_map.end()){
            //                						errs() << "Trying to rename" << *II << "\n";	
                                                    PN->setIncomingValue(op,renaming_map[PN->getIncomingValue(op)]);
                                                }
                                        }
                                }
                                else {
                                        for(int op = 0; op < II->getNumOperands(); op++){
                                                if(renaming_map.find(II->getOperand(op)) != renaming_map.end() && 
                                                        DT->dominates(rename_BB_map[renaming_map[II->getOperand(op)]],II->getParent())){
                                                        II->setOperand(op,renaming_map[II->getOperand(op)]);
              //                                          errs() << "Trying to rename" << *II << "\n";
                                                        string block_name = (std::string)(BB)->getName();
                                        	}
                                	}
                        	}
                	}
		}	
	
//        errs() << "Test1 \n";    
        preheader_end = p->end();
        secondLast = --preheader_end;
        build_ir.SetInsertPoint(secondLast);
        AllocaInst * flag = build_ir.CreateAlloca(Type::getInt1Ty(getGlobalContext()),0,"flag");
        build_ir.CreateStore(ConstantInt::getFalse(getGlobalContext()), flag);

  //      errs() << "Test2 \n";  
        BasicBlock* trace_begin = *(t.begin());
        BasicBlock::iterator trace_bb_end = trace_begin->end();
        secondLast = --trace_bb_end;
        build_ir.SetInsertPoint(secondLast);
        build_ir.CreateStore(ConstantInt::getFalse(getGlobalContext()), flag);

//	errs() << "Test3 \n";
        trace::iterator ttt = t.end();
        --ttt;
        BasicBlock* trace_last = *(ttt);
        trace_bb_end = trace_last->end();
        secondLast = --trace_bb_end;
  //      errs() << "SecondLast = " << *secondLast << "\n";
        build_ir.SetInsertPoint(secondLast);
        build_ir.CreateStore(ConstantInt::getTrue(getGlobalContext()), flag);	
	
	BasicBlock* non_trace_start;
	for(trace::iterator II = t.begin(); II != t.end(); II++) {
		string block_name = (std::string)(*II)->getName();
                if(block_name.find("for.body") != std::string::npos ){
			for(succ_iterator i = succ_begin(*II); i != succ_end(*II); i++){
				if(find(t.begin(),t.end(),*i) == t.end()){
					non_trace_start = *i;
					break;	
				}
			}
		}
	}
	std::list<BasicBlock*> visited;
      	std::queue<BasicBlock*> q;
        visited.push_back(non_trace_start);
        q.push(non_trace_start);
	BasicBlock* modify_block;
        while(!q.empty()){
        	BasicBlock* current_block = q.front();
                q.pop();
                visited.push_back(current_block);
        	string block_name = (std::string)current_block->getName();
                if(block_name.find("for.inc") != std::string::npos ){
			modify_block = current_block;
			break;
		}
		for(succ_iterator i = succ_begin(current_block); i != succ_end(current_block); i++){
			q.push(*i);
		}
	}
	ValueToValueMapTy vtovmap;
	Value* rhs;
	BasicBlock* modify_block_clone = CloneBasicBlock(modify_block,vtovmap,"_copy",CurFunc);
	for (BasicBlock::iterator II = modify_block_clone->begin(), ie = modify_block_clone->end(); II != ie; ++II) {
        	for(unsigned int i=0;i<II->getNumOperands();i++)
               	{
                	if(vtovmap.find(II->getOperand(i)) != vtovmap.end())
                        {
                        	rhs = vtovmap[II->getOperand(i)];
                                II->setOperand(i,rhs);
                        }      	
               	}
	}
	BasicBlock* modify_block_pred = *(pred_begin(modify_block));
	BasicBlock::iterator home_end = modify_block_pred->end();
        secondLast = --home_end;
	build_ir.SetInsertPoint(secondLast);
	Value* cond  = build_ir.CreateLoad(flag);
	build_ir.CreateCondBr(cond,modify_block,modify_block_clone);
        modify_block_pred->getTerminator()->eraseFromParent();

	for(succ_iterator i = succ_begin(modify_block); i != succ_end(modify_block); i++){
        	for (BasicBlock::iterator II = (*i)->begin(), ie = (*i)->end(); II != ie; ++II) {
			if(isa<PHINode>(*II))
                        {
                                Instruction *U = II;
                                PHINode *PN = dyn_cast<PHINode>(U);
                                for(unsigned int i = 0; i < PN->getNumIncomingValues(); i++) {
                                        if(PN->getIncomingBlock(i) ==  modify_block) {
                                        	if(vtovmap[PN->getIncomingValue(i)]){
							PN->addIncoming(vtovmap[PN->getIncomingValue(i)],modify_block_clone);
							break;
						} else {
							PN->addIncoming(PN->getIncomingValue(i),modify_block_clone);	
						}
					}
                                }
                        }	
		}
       	}
	
	Instruction* instr = modify_block_clone->begin();
	instr->setOperand(instr->getNumOperands()-1,ConstantInt::getSigned(Type::getInt32Ty(getGlobalContext()),inc));
	BasicBlock::iterator asd= modify_block_clone->end();
	asd--;
	build_ir.SetInsertPoint(asd);
	
        ld = build_ir.CreateLoad((Value*)induction_map[0]);
	Instruction* inc_instr = instr->clone();
	inc_instr->insertBefore(asd);
	inc_instr->setOperand(0,(Value*)ld);
	build_ir.CreateStore((Value*)ld, induction_map[0]);
	
	//instr->setOperand(instr->getNumOperands()-1,ConstantInt::getSigned(Type::getInt32Ty(getGlobalContext()),inc));
}

	bool hasBackedge(trace t){
		trace::iterator tmp = t.end();
		tmp--;
		BasicBlock* last = *(tmp);
//		errs()<<"first basic block - "<< (*(t.begin()))->getName() <<"\tlast basic block - "<<last->getName()<<"\n";
		for(succ_iterator succ = succ_begin(last);succ != succ_end(last);succ++){
			if(*succ == *(t.begin()))
				return true;
		}
		return false;
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
	void getAnalysisUsage(AnalysisUsage &AU) const {
		AU.addRequired<ProfileInfo>();
		AU.addRequired<LAMPLoadProfile>();
		AU.setPreservesCFG();
	        AU.addRequired<DominatorTree>();
		AU.addRequired<LoopInfo>();
	}
  };
}

char IndVar::ID = 0;
static RegisterPass<IndVar> X("indvar", "IndVar Pass");
