# Notes CM1

* Use teams to contact not mail
* Own laptop

To do:
* Repo name must be **ics0010-2021f** + don't forget gitignore
* Dotnet 5.0 SDK to download DONE
* Jetbrains reshaper


## Actually interesting things ? i guess

Solution = collection of projects

Create a console application on jetbrains and then you add more projects in the sol

## Youhoo some code finally

### Fields

like variables, can be read and set directly

### Properties

Have get and set procedures, more control over values

Auto-implementing property

Write in VS/Rider: prop + TAB for editor help

Need more control - have a backing field and provide logic for storing and retrieving

### Types 

When using `long`, need to add L a the end like `long myVar = 100000L;`

Same for `float` :  `float myVar=5.75F`

And `double` : `double myNum = 19.99D;`

`string`is surrounded by double quotes `"string"`

### Casting

*Implicit* when go to a larger type (for example char -> int or int->float)

*Explicit* when go to smaller type (long->int or double->float for example)

    double myD = 7.52;
    int myI = (int) myD;

### Classes

Can do nested class and inheritance

By default constructor and destructor (with ~ before)

Only one destructor by class

Use `IDisposable` instead of destructor

### Access modifiers

*public* : accessed by any other code in the same assembly or assembly that refer to it

*private* : only accessed by the same class

*protected*: only by same class or derived

*internal* : accessed by any code in the same assembly but not from another

*protected internal* : any code in the same assembly or any derived class in another assembly

### Static class

Smthg static is shared by all instances of a class

### Anonymous types

Compiler generate a class for you (var Sample = new {code};)

### Inheritance 

Not be used as a class base :

    public sealed class A{}

Only be used as a base class (no instanciation):

    public abstract class B{}

### Overriding

*virtual* : allow a class member to be overriden in derived clqss

*override* : to override member in the base class

*abstract* : requires to be overriden in derived

*new* : hides a member inherited from base class : replace the member from base class (if not use -> warning)


