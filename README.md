# VMM

Jenkins integration with virtual machine management (VMM)

1.Pipeline start

  ![](img/pipeline-start.png)

2. Pipeline result
  ![Pipeline result](img/pipeline-result.png)
  
3. Archive file

  ```
  #####################################################
  ######### VM login check via SSH results ############
  #####################################################
  #                                                   #
  # Compelted (success) 14/16 (total) login vm check. #
  #                                                   #
  # Below 2 host(s) login faied, need to check.       #
  #                                                   #
       abc.company.com 
       xyz.company.com 
  #                                                   #
  #####################################################
  ```

## Backgroud

In order to solve some important but infrequently used virtual machines, if the system is not logged in for a long time, it will be regarded as temporarily unused by the system, resulting in being shut down. When it is used again, it is necessary to ask the administrator to perform such troublesome operations.

A script is required to log in regularly and execute simple commands to allow the system to determine that these virtual machines are active, so as not to shut it down.

## Demand analysis

From a background perspective, regular ssh login operations can be achieved through a simple shell script, but it will take some time to achieve more elegant.

Imaginary elegance:

1. Regular automatic execution
2. Output more intuitive login test results
3. Support users to add new virtual machine hostname to the checklist
4. After the execution is completed, notify the user and so on.

I hope to use existing scripts (Jenkins) to use shell scripts and pipelines without introducing other Web pages.

## Demand breakdown

1. Write a script to loop through all the hostnames in a list. After consideration, this list is preferably a file, which is convenient for subsequent processing.
2. In this way, when the user passes in a new hostname by executing the Jenkins job, the intentional hostname is grep in the file
3. If grep arrives, do not add. If there is no grep, add the hostname to the file.
4. Add this modified file to the git repository so that next time Jenkins' scheduled task will execute the recently added hostname.

## Code implementation

Refer to the repository code. Please note that the code here is just an example, and there may be some execution failures, but I think you'll be able to fix them very soon.
