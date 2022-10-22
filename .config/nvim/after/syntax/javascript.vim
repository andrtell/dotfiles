syn clear
syn case match

syntax region  javascriptComment        start=+//+ end=/$/
syntax region  javascriptComment        start=+/\*+  end=+\*/+

syn sync minlines=2000
