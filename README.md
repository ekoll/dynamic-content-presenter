# Dynamic Content

An app fills it's form according to a json data with specific format. All views are designed and layout programmatically. And there is no third party library or framework in this project.

Supports `textField`, `pickerField` and `label`. Each field can have `title` and `hint`. App is totaly oriented on displaying different items according to config. So some details like error handling and architectre is a bit "not proper". Or would be better.

In order to display dynamic amount of data, I used `UIScrollView` with vertical `UIStackView` inside of it. But this might turn into a bad approach when there are looot's of fields.

Technically there are 2 custom views in the project (`FieldView` and `PickerField`). But `FieldView` is a superview. It will be on every field on the list and will contain the field in the config inside. For example: If there is a `textField` in config, that `textField` will be displayed in `FieldView`. `FieldView` also holds title and hint info of every field. And both of those are moved here from my old projects.
