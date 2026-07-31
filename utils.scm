(define-module (utils)
  #:use-module (haunt builder blog)
  #:use-module (haunt html)
  #:use-module (haunt artifact)
  #:export (anchor
            icon-content
            icon-link
            static-page))

(define (anchor content uri)
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
  (icon-content (anchor content uri) icon-name))
