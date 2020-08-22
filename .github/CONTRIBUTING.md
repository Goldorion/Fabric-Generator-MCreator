# Contributing to MCreator Fabric Generator

Since we have limited time, we would love to accept pull requests to get things done. We've also put a few ground rules so that pull requests can be maintained easily and follow the same codestyle.

## Checkstyle
* Keep minor changes like bug fixes and spelling errors a separate commit
* State all your changes
* Do *not* use newline brackets
* Rebase and force-push or manually merge changes if there are merge conflicts. 
* Use descriptive commit messages. A small description of what was done is enough.
* Always annotate client-side methods with `@Environment(Envtype.CLIENT)`
* Always annotate overridden methods with `@Override`
* Follow java naming conventions
* Use the `this` keyword when referencing any non static fields from a non static context. 
* Do not commit with CRLF line endings. Also Try adding a newline at the end of each file. 
* Do not use mixins. Fabric Api has, or will soon have all the required modules. 

You must also follow the [Code Of Conduct](https://github.com/ClothCreators/MCreatorFabricGenerator/blob/1.15.2/CODE_OF_CONDUCT.md).
