
The following commands are currently available:

#### 1. flutter_example 
flutter_example can automatically create a project to run the example based on the current directory.

For example, package has a directory example, which has lib and pubspec.yaml. There is no need to list the specified platform. 

Just use flutter_example to automatically create the platform files needed to run the example. After running example, you can delete the build directory manually or execute flutter clean.

#### 2. flutter_clean 
flutter_clean can recursively clear all projects in the current directory

## How to use

```sh
dart pub global activate flutter_helper_cli

# then you can run
flutter_example
```
