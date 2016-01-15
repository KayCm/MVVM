#!python
#encoding:utf-8

import os

addBash = os.popen('git add -A  *').readlines()

print(addBash)

print('Add Success!')

CommitTxt = raw_input('Input Commit Text:\n')

commitBash = os.popen('git commit -m' +' "'+CommitTxt+'" '+'*').readlines()

print(commitBash)

print('Commit Text:'+CommitTxt+' Success! ') 

pushBash  = os.popen('git push origin master  *').readlines()

print(pushBash)

print('Push Success')

isTrunk = raw_input('Is trunk Push?(Yes/No)')

if isTrunk == "Yes" or isTrunk == "yes" or isTrunk == "YES":
 print('Start To Trunk')

 tagTxt = raw_input('Input Tag Text:\n')

 tagBash = os.popen('git tag ''+tagTxt+''  *').readlines()

 tagPush = os.popen('git push --tags  *').readlines() 

 podspecFile = os.popen('ls *.podspec').readlines()

 trunkPush = os.popen('pod trunk push '+podspecFile[0]+'  *').readlines()

else:
 print('no')


