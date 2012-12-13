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
