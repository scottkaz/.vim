" Remove error highlighting for underscores in markdown
"
" Original error pattern
"syn match markdownError "\w\@<=_\w\@="
" New error pattern without the underscore
syn match markdownError "\w\@<=\w\@="

