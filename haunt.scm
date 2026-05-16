(use-modules (haunt asset)
             (haunt site)
             (haunt builder assets)
             (haunt builder atom)
             (haunt builder blog)
             (haunt builder flat-pages)
             (haunt reader)
             (haunt reader commonmark)
             (haunt reader skribe))


(define (anchor content uri)
  `(a (@ (href ,uri)) ,content))


(define domain "phoebeharris.xyz")

(define haunt-theme
  (theme #:name "Theme"
         #:layout
         (lambda (site title body)
           `((doctype "html")
             (head
              (meta (@ (charset "utf-8")))
              (meta (@ (name "viewport") (content "width=device-width, initial-scale=1")))
              (link (@ (rel "alternate")
		               (type "application/atom+xml")
		               (title "Phoebe Harris")
		               (href "/atom.xml")))
              (link (@ (rel "stylesheet")
                       (href "/css/main.css")
                       ))
              )
             (body
              (header (@ (class "header"))
                      (nav (ul
                            (li (h3 ( ,(anchor "home" "/"))))
                            (li (h3 ( ,(anchor "now" "/now.html"))))
                            (li (h3 ( ,(anchor "projects" "/projects.html"))))
                            ))
                      )
              ,body
              )
             )
           )

         ))

(site #:title "Phoebe Harris"
      #:domain domain
      #:default-metadata
      '((author . "Phoebe Harris")
        (email  . "phoebe.harris.2024@proton.me"))
      #:readers (list commonmark-reader skribe-reader)
      #:builders (list (blog #:theme haunt-theme)
                       (flat-pages "pages" #:template (theme-layout haunt-theme))
                       (static-directory "css")
                       (atom-feed)
                       (atom-feeds-by-tag)))
