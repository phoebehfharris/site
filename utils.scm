(define-module (utils)
  #:use-module (haunt builder blog)
  #:use-module (haunt html)
  #:use-module (haunt artifact)
  #:export (anchor
            icon-content
            icon-link
            project
            static-page))

(define (anchor content uri)
  (display uri)
  `(a (@ (href ,uri)) ,content))



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

(define (icon-link content uri icon-name)
  (anchor (icon-content content icon-name) uri))

(define (project name description link)
  `(section
    (@ (class "project"))
    (div (@ (class "project-header"))
         (h4 ,name)
         ,(if (list? link)
              `(div (@ (class "git-icons")) ,(map (lambda (s) (icon-link "" s "github.svg")) link))
              (icon-link "" link "github.svg")))
    ,@description
    ))
