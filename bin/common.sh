# To replace all spaces with dashes in file names
rename 's/ /-/g' src/public/documents/products/Auxiliaries/**/*

# To replace all closing parantheses
rename 's/\)//g' src/public/documents/products/Solder-wires/**/*

# Do a rename dry-run
rename -nv
