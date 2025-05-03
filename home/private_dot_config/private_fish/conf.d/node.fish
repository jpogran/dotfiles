# Node and TypeScript
set -gx NODE_OPTIONS "--max-old-space-size=4096"

# NPM abbreviations
abbr -a ni 'npm install'
abbr -a nid 'npm install --save-dev'
abbr -a nig 'npm install -g'
abbr -a nr 'npm run'
abbr -a nrs 'npm run start'
abbr -a nrt 'npm run test'
abbr -a nrb 'npm run build'
abbr -a nrd 'npm run dev'

# TypeScript abbreviations
abbr -a tsc 'npx tsc'
abbr -a tsb 'npx tsc --build'
abbr -a tsw 'npx tsc --watch'
