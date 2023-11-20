# Errors in ffigen

This file documents various errors and potential fixes related to running ffigen.

## Errors in source header files

Under the hood ffigen uses libclang to parse header files. Any compiler warnings/errors would be logged as severe, these should ideally be resolved as it can potentially general to invalid bindings that might lead to errors at runtime.

You can pass in args to libclang using  `compiler-opts` via cmd line or yaml config or both.

Here are a some common usecases. You can find the full list of [supported args here](https://clang.llvm.org/docs/ClangCommandLineReference.html#id5).

### Missing headers

```yaml
compiler-opts:
  - "-I/path/to/folder"
```

### Ignoring source errors

As a last resort, you can pass in `--ignore-source-errors` or set `ignore-source-errors: true` in yaml config.
