syn clear
syn case match

syntax region  typescriptComment        start=+//+ end=/$/
syntax region  typescriptComment        start=+/\*+  end=+\*/+
