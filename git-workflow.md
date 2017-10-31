# Git Workflow for StockBox

### Working and Tracking changes
* if you have not created a new branch to work from then do so
  * **git branch** ***new-branch-name***
* switch to your branch
  * **git checkout branch**
* make your changes, test, etc.
  * **git add *** or **git add .**
  * **git commit -m "change description"**

### Pushing Changes
* switch to master
  * **git checkout master**
* pull recent changes from the remote
  * **git pull origin master**
* if there are new changes to master
  * switch back to you feature branch
  * **git checkout** ***branch-name***
  * **git merge master**
  * if there are any conflicts you will need to manually resolve them, looking for the ==== and <<<< in the conflicting files.
    * do another **git merge master** and confirm there are no more conflicts.
    * repeat as necessary
    * Test your code with the new changes.
  * if all is well switch back to master
    * **git checkout master**
* merge the changes from your feature branch
  * **git merge** ***branch-name***
* push the changes to the origin
  * **git push origin master**

### Notes
