(define-module (utils)
  #:use-module (haunt builder blog)
  #:use-module (haunt html)
  #:use-module (haunt artifact)
  #:export (anchor
            static-page))

(define (anchor content uri)
  `(a (@ (href ,uri)) ,content))



(define (static-page title theme file-name body)
  (lambda (site posts)
    (serialized-artifact file-name
                         ((theme-layout theme) site title body)
                         sxml->html)))
