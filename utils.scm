(define-module (utils)
  #:use-module (haunt builder blog)
  #:use-module (haunt html)
  #:use-module (haunt artifact)
  #:export (anchor
            icon-content
            icon-link
            project
            static-page
	        tooltip))

(define* (anchor content uri #:optional screenreader-text)
  (display uri)
  `(a ( @ (href ,uri)
          ,@(if screenreader-text
                `((aria-label ,screenreader-text))
                '()))
    ,content))

(define (tooltip content tip)
  `(span (@ (class "tooltip"))
	,content
	(span (@ (class "tooltiptext")) ,tip)))


(define (static-page title theme file-name body)
  (lambda (site posts)
    (serialized-artifact file-name
                         ((theme-layout theme) site title body)
                         sxml->html)))

(define (icon-content content icon-name)
  `(span
    (@ (class "icon-content"))
    (img (@
          (src ,(string-append "static/icons/" icon-name))))
    ,content))

(define (icon-link content uri icon-name sr-label)
  (anchor (icon-content content icon-name) uri sr-label))

(define (project name description link)
  `(section
    (@ (class "project"))
    (div (@ (class "project-header"))
         (h4 ,name)
         ,(if (list? link)
              `(div (@ (class "git-icons")) ,(map (lambda (s) (icon-link "" s "github.svg" "GitHub repo")) link))
              (icon-link "" link "github.svg" "GitHub repo")))
    ,@description))
