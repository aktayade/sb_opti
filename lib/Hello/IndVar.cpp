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

		errs()<<"Starting induction variable optimization\n";
		for (itr = traces.begin(); itr != traces.end(); ++itr) {
			if(backedge[*itr]){
				errs()<<"Current trace : \n";
		        	printTrace(*itr);
				induction_variable(*itr,2);
			}
                }
		CurFunc = NULL;
		errs()<<"Finished\n";
	        return false;
        }
	list<trace> readTracesFromFile(){
		ifstream is ("superblocks");
		string line,word;
		list<trace> traces;
		if(is.is_open()){
			while(is.good()){
				getline(is,line);
				int pos = 0;
				errs()<<"line = "<<line<<"\n";
				if(line.size() == 0){
					break;
				}
				trace t;
				while(line.find(" ",pos) != -1){
					int end = line.find(" ",pos);
					errs()<< end <<"\t"<<pos<<"\n";	
					word = line.substr(pos,end-pos);
					errs()<<"word = "<<word<<"\n";
					pos = end+1;
					for (Function::iterator BB = CurFunc->begin(), e = CurFunc->end(); BB != e; ++BB){
						if(word.compare((BB->getName()).data()) == 0){
							t.push_back(&(*BB));
						}
					}
				}
				word = line.substr(pos,line.size()-pos);
				errs()<<"word = "<<word<<"\n";
				if(word.compare("yes")==0){
					backedge.insert(make_pair(t,true));
				}
				else{
					backedge.insert(make_pair(t,false));
				}
				traces.push_back(t);
				errs()<<"done\n";
			}
		}
		return traces;
	}
	
	void induction_variable(trace t,int unroll_count){
		BasicBlock* first = *(t.begin());
		BasicBlock* p = L->getLoopFor(first)->getLoopPreheader();
		errs()<<"induction variable = "<<(Value*)(L->getLoopFor(first)->getCanonicalInductionVariable())<<"\n";
		Value *induc_var, *label, *initialVal, *increment;
		BasicBlock::iterator temp = (first)->end();
		int increment_opcode = -1;
		Instruction* induction_inst;
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
	
		errs() << "The induction variable is: " << (*induc_var) << "\n";
		errs() << "The initial value: " << (*initialVal) << "\n";
		errs() << "The increment is: " << (*increment) << "\n";
		
		IRBuilder<> build_ir(p);
		BasicBlock::iterator preheader_end = p->end();
                Instruction * secondLast = --preheader_end;
                build_ir.SetInsertPoint(secondLast);
		std::map<int,AllocaInst*> induction_map;
                AllocaInst * ainst = build_ir.CreateAlloca(induc_var->getType(),0,"induction");
                build_ir.CreateStore(initialVal, ainst);
		induction_map.insert(make_pair(0,ainst));
		llvm::ConstantInt* CI = dyn_cast<llvm::ConstantInt>(initialVal);
		int init_value = CI->getSExtValue();
		llvm::ConstantInt* CInc = dyn_cast<llvm::ConstantInt>(increment);
                int inc = CInc->getSExtValue();
		int ind_initval=init_value;
		errs()<<"initial = "<<init_value<<"\tinc="<<inc<<"opcode = "<<increment_opcode<<"\n";
		for(int i = 1;i<unroll_count;i++){
			if(increment_opcode == 8 || increment_opcode == 9){
				ind_initval = ind_initval+inc;		
			}
			else if(increment_opcode == 10 || increment_opcode == 11){
				ind_initval = ind_initval-inc;
			}
			else if(increment_opcode == 12 || increment_opcode == 13){
				ind_initval = ind_initval * inc;
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
		/*for (Value::use_iterator i = induc_var->use_begin(), e = induc_var->use_end(); i != e; ++i){
			errs()<<"inside def use\n";
			Instruction *Inst = (Instruction*)(*i);
			errs()<<"inside def use\t*********************************************\n";
			errs()<<"inst = "<<*Inst<<"\n";
			if(isa<PHINode>(*i))
                        {
				errs()<<"Phi node found \n";
                                Instruction *U = (Instruction*)(*i);
                                PHINode *PN = dyn_cast<PHINode>(U);
                                for(unsigned int k = 0; k < PN->getNumIncomingValues(); k++) {
                                        if(PN->getIncomingValue(k) ==  induc_var) {
                                                PN->setIncomingValue(k,(Value*)ld);
                                        }
                                }
                        }
			else{
				for(unsigned int j=0;j<Inst->getNumOperands();j++){
					if(i->getOperand(j) == induc_var){
						errs()<<"inst = "<<*i<<"\treplace = "<<*((Value*)ld)<<"\n";
						Inst->setOperand(j,((Value*)ld));
						errs()<<"updated inst = "<<*i<<"\n";
					}
				}
			}
  			
		}*/
		
//		induction_inst->eraseFromParent();
		Value *lhs = (Value*)ld;
		std::map<int,Value*> unroll_var;
		std::map<Value*,int> unroll_var_inverse;
		for(Function::iterator BB = CurFunc->begin(); BB != CurFunc->end();BB++){
			for(BasicBlock::iterator II = BB->begin(); II != BB->end(); II++){
				errs()<<"loop starting...\n";
				if(isa<PHINode>(*II)){
					Instruction *U = II;
                	                PHINode *PN = dyn_cast<PHINode>(U);
					for(int op = 0; op < PN->getNumIncomingValues(); op++){
						if(PN->getIncomingValue(op) == induc_var){
							errs()<<"replacing op in phi node\n";
							BasicBlock* tmp = PN->getIncomingBlock(op);
							PN->removeIncomingValue(op);
							PN->addIncoming(lhs,tmp);
							errs()<<"Instruction = "<<*II<<"\n";
						}
					}
				}
				else {
					for(int op = 0; op<II->getNumOperands(); op++){
						if(II->getOperand(op) == induc_var){
							II->setOperand(op,lhs);
							errs()<<"operand set\n";
							errs()<<"Instruction = "<<*II<<"\n";
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
		std::map<Value*,Value*> lhs_rhs;	
		for(Function::iterator BB = CurFunc->begin(); BB != CurFunc->end();BB++){
			string block_name = (std::string)(BB->getName());	
			if(block_name.find("for.inc") == std::string::npos && block_name.find("for.cond") == std::string::npos ){
				continue;
			}
			if(block_name.find("for.inc") != std::string::npos){
				for(BasicBlock::iterator II = BB->begin(); II != BB->end(); II++){
					Value *rhs = II->getOperand(0);
					
					if(find(t.begin(),t.end(),BB) != t.end()){
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
			}
			else if(block_name.find("for.cond") != std::string::npos){
				if(find(t.begin(),t.end(),BB) != t.end()){
                                }
				else{
					BasicBlock::iterator preheader_end = BB->end();
	                                Instruction * secondLast = --preheader_end;
					Instruction * thirdLast = --preheader_end;
					errs()<<"secondlast = "<<*thirdLast<<"\n";	
					Value *rhs = thirdLast->getOperand(0);
					int u = unroll_var_inverse[rhs];
					build_ir.SetInsertPoint(BB->getFirstNonPHI());
		                	LoadInst* l = build_ir.CreateLoad((Value*)induction_map[u+1]);
					errs()<<"key = "<<*rhs<<"\tvalue = "<<*((Value*)l)<<"\n";
					lhs_rhs.insert(make_pair(rhs,(Value*)l));
					errs()<<",,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,\n";
				}
			}
		}
		

		for(Function::iterator BB = CurFunc->begin(); BB != CurFunc->end();BB++){
                        for(BasicBlock::iterator II = BB->begin(); II != BB->end(); II++){
                                if(isa<PHINode>(*II)){
                                        Instruction *U = II;
                                        PHINode *PN = dyn_cast<PHINode>(U);
                                        for(int op = 0; op < PN->getNumIncomingValues(); op++){
                                                if(lhs_rhs.find(PN->getIncomingValue(op))!= lhs_rhs.end()){
                                                        //errs()<<"replacing op in phi node\n";
                                                        //BasicBlock* tmp = PN->getIncomingBlock(op);
                                                        //PN->removeIncomingValue(op);
							PN->setIncomingValue(op,lhs_rhs[PN->getIncomingValue(op)]);
                                                        //PN->addIncoming(lhs_rhs[PN->getIncomingValue(op)],tmp);
                                                        //errs()<<"Instruction = "<<*II<<"\n";
                                                }
                                        }
                                }
                                else {
                                        for(int op = 0; op < II->getNumOperands(); op++){
                                                if(lhs_rhs.find(II->getOperand(op)) != lhs_rhs.end()){
                                                        II->setOperand(op,lhs_rhs[II->getOperand(op)]);
                                                        //errs()<<"operand set\n";
                                                        //errs()<<"Instruction = "<<*II<<"\n";
                                                        string block_name = (std::string)(BB)->getName();
                                        	}
                                	}
                        	}
                	}
		}

			
		
	}

	bool hasBackedge(trace t){
		trace::iterator tmp = t.end();
		tmp--;
		BasicBlock* last = *(tmp);
		errs()<<"first basic block - "<< (*(t.begin()))->getName() <<"\tlast basic block - "<<last->getName()<<"\n";
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
