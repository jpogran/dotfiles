
Copy-Item -Recurse -Force git ${HOME}
Copy-Item -Recurse -Force ruby ${HOME}
Copy-Item -Recurse -Force vim ${HOME}
Copy-Item -Recurse -Force zsh ${HOME}

Copy-Item -Path vscode/settings.json -Destination c:/users/james/appdata/roaming/code/user/settings.json
Copy-Item -Path vscode/keybindings.json -Destination c:/users/james/appdata/roaming/code/user/keybindings.json