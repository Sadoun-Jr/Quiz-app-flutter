# Quiz-Flutter
Created while learning flutter, it is my first flutter project.

I started using Git midway while working on this project, so the first version/commit will be at a midpoint.
This is a Quiz app that utilises firebase as its backend, and allows 2 different types of users to interact with the app accordingly. The first type is "admin", this is meant for quiz creators. They can CRUD quizzes and sync quizzes with the firestore database. The second type is "user" , this is meant for quiz takers. They can only read the quizzes from the database, and will have their scores on their profiles updated automatically for admins to view.

# ( ✓ ) Create layouts

# (  ) Create logic

( ✓ ) Add firebase to project<br />
( ✓ ) Login and Register<br />
( ✓ ) Ability to register as admin<br />
( ✓ ) Ability to detect if user is admin or not and load appropriate layout<br />
( ✓ ) Admins can create new quizzes<br />
( ✓ ) Admins can view the quizzes they created<br />
( ✓ ) Admins can choose a specific quiz to edit and view its questions<br />
( ✓ ) Admins can choose a specific question to edit/delete and sync to database<br />
( ... ) Display single question details in the "edit single quiz layout admin" file properly to have the ability  edit the question<br />


# Known bugs in this version:

1- "edit quiz list" displays old data when accessed and takes 2 seconds to refresh, because of a future() function in its initState() method. I did this because somehow the list that contains the entire list of quiz questions gets cleared right after the future() function.

NOTE: Project is on hold due to work on my technicians app project
