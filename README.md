# BoostedOBU 
The main file is BoostOBU.R, and the supporting files for running the main file are all provide here. 
To run AdaOBU, in the main file, the user comment Line 53 to leave out Borderline-SMOTE.

Results.zip contains 3 files of our experimental results on 23 real-world datasets as follows:
1) results_AdaOBU_SVM_kNN_J48_RF.xlsx 
     - Results of AdaOBU with SVM, J48, kNN and RF 
     - T-test results of AdaOBU with SVM against AdaOBU with other algorithms 
2) results_BoostOBU_SVM_kNN_J48_RF.xlsx 
     - Results of BoostOBU with SVM, J48, kNN and RF 
     - T-test results of BoostOBU with SVM against BoostOBU with other algorithms 
3) results_BoostOBU_AdaOBU_SMOTEENN_SMOTEBagging_SVM.xlsx 
     - Results of AdaOBU, BoostOBU, SMOTE-ENN and SMOTEBagging (all with SVM)
     - T-test results of AdaOBU against SMOTE-ENN and SMOTEBagging
     - T-test results of BoostOBU against SMOTE-ENN and SMOTEBagging
