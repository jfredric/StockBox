# Git Workflow for StockBox

### Working and Tracking changes
if you have not created a new branch to work from then do so
  * **git branch** ***new-branch-name***

switch to your branch
  * **git checkout** ***branch***

Commit changes when you have done all the following:
  * make your changes
  * compile successfully
  * run and test for correct behavior without crashing (or at least new crashes related to new changes)
  * if either fails got back to making changes
  * **git add *** or **git add .**
  * **git commit -m "change description"**
    * If you only made one change a single line description is fine.
    * If you touched multiple files, added or updated more than one feature, etc then you should be entering multiple lines in the description, with bullets/dashes. You do this by pressing enter without the closing ". Example:
    ```
    commandline useraname$ git commit -m "- change 1
    > - change 2
    > - change 3"
    ```
    Ask Josh if you need help with this.


  Note: if you have successfully compiled and ran and you have not committed in the last hour, you are not committing soon enough.

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
