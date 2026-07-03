import Lake
open Lake DSL

package lean_connes_kreimer where

lean_lib ConnesKreimer where

require mathlib from git
  "https://github.com/leanprover-community/mathlib4.git" @
    "07642720480157414db592fa85b626dafb71355b"
