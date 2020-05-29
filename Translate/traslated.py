#===============================================================
#  calibration and comparison of uncertainty scores
#  Does drop out generate good uncertainties?
#...............................................................
#

# CHANGELOG
#
# 2020-05-26
#   Translation to python3 by EA. Some operations changed in
#   sequence of execution, some were replaced with for loops.

#...............................................................
# libraries
import os  # read/change work dir
import glob # list files on dir
import numpy as np # fns used: unique
import pandas as pd  # DataFrame is quite similar to R style
#import statistics as st # fns used: median
from math import exp  # only this function is used

#...............................................................
# implementation of grep
def grep(expr,vect,ret='index'):
    ind = list(range(len(vect)))
    log = [False]*len(vect)
    for i in ind:
        log[i] = (expr in vect[i])
    if ret=="index":
        return np.array(ind)[log].tolist()
    if ret=="logic":
        return log
    if ret=="value":
        return np.array(vect)[log].tolist()

#...............................................................
# input the data

#os.chdir("~/LANL/Current/NCI-P1/ICML2020/ICML_Analysis")

ffiles = np.array(glob.glob("./**/*txt*"))
# NOTE ON SYNTAXIS:
# ./**/ means: search in all subdirs, but not current dir
# *txt* means: (SOMETH)txt(SOMETH); use one/two sides as needed

datasets = [fname.split("\\")[1] for fname in ffiles]
# NOTE ON SYNTAXIS: arrays start at 0 on python, but at 1 in R

model_type = np.array( ["hom"]*len(ffiles) )
idx = grep("het",ffiles,ret="logic")
model_type[idx] = ["het"]*len(idx)
model_type = model_type.tolist()
# NOTES ON SYNTAXIS:
# R variable names can have dots, but in Python is not allowed
# Python lists can't be indexed by lists, but numpy arrays can

idx_hom = [mt=="hom" for mt in model_type]
idx_het = [mt=="het" for mt in model_type]

#  pick a dataset
for dat_name in np.unique(datasets):
    idx_data = grep(dat_name,datasets,ret="logic")
    
    # read the datasets
    #... homogeneuous model
    dat_hom = ( pd.read_csv(file,header=False,sep=" ") \
              for file in ffiles[idx_data and idx_hom][0] )
    dat_hom.index = ["true"] + ["E."+str(i) for i in range(1,201)]
    rep_hom = list(range(2,202))
    # NOTES ON SYNTAXIS:
    # range(1,200) does not include 200, so 201 is used
    # index =is= rownames, columns =is= colnames
    
    #... heterogeneuous model
    dat_het = ( pd.read_csv(file,header=False,sep=" ") \
              for file in ffiles[idx_data and idx_het][0] )
    dat_het.index = ["true"] + \
                ["E."+str(i)+"S."+str(i) for i in range(1,201)]
    rep_het = list(range(2,202))*2 # different code, same result
    rep_het.sort()
    
    #................
    #  response
    Y = dat_het["true"]
    
    #................
    # Score S1 mean abs dev of hetero pred 
    idxE = grep("E.",dat_het.columns,ret="val")
    fbar_het = dat_het[:,idxE].median(axis=1)
    nc = len(idxE)
    nr = len(fbar_het)
    #Mbar = 
    S1 = [st.median([abs(dat_het[rr,idxE])-fbar_het[rr]])\
          for rr in dat_het.index]
    
    # Score S2 is median of sd
    idxS = grep("S.",dat_het.columns,ret="val")
    S2 = [st.median([exp(dat_het[rr,ii]/2) for ii in idxS])\
          for rr in dat_het.index]
    
    # Score S3 is mean abs of homo
    idxE = grep("E.",dat_hom.columns,ret="val")
    fbar_hom = dat_hom[:,idxE].median(axis=1)
    nc = len(idxE)
    nr = len(fbar_hom)
    #Mbar = 
    S1 = [st.median([abs(dat_hom[rr,idxE])-fbar_hom[rr]])\
          for rr in dat_hom.index]
    

    #.....
    # Loss
    Z1 = abs( Y - fbar_hom )  # for homogeneaous model
    Z2 = abs( Y - fbar_het )  # for hetogeneaous model
    
    #######################################################
    # Calibration (using ranks)

#plt.savefig("calibration.pdf")  # file is created after plot is completed