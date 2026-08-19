(use-modules (haunt asset)
             (haunt site)
             (haunt builder assets)
             (haunt builder atom)
             (haunt builder blog)
             (haunt builder flat-pages)
             (haunt reader)
             (haunt reader commonmark)
             (haunt reader skribe)
             (index)
             (utils))

(define domain "phoebeharris.xyz")

(define haunt-theme
  (theme #:name "Theme"
         #:layout
         (lambda (site title body)
           `((doctype "html")
             (html (@ (lang "en-GB"))
                   (head
                    (meta (@ (charset "utf-8")))
                    (meta (@ (name "viewport") (content "width=device-width, initial-scale=1")))
	                (meta (@ (name "description") (content "A personal website for Phoebe Harris")))
	                (meta (@ (name "theme-color") (content "#eff1f5") (media "prefers-color-scheme: light")))
	                (meta (@ (name "theme-color") (content "#1e1e2e") (media "prefers-color-scheme: dark")))
	                (meta (@ (name "color-scheme") (content "dark light")))
                    (meta (@ (property "og:title") (content ,title)))
	                (link (@ (rel "canonical")
		                     (href "phoebeharris.xyz")))
                    (link (@ (rel "preload")
                             (type "font/woff2")
                             (as "font")
                             (href "/static/Ubuntu-Regular.woff2")))
                    (link (@ (rel "alternate")
		                     (type "application/atom+xml")
		                     (title "Phoebe Harris")
		                     (href "/atom.xml")))
                    (link (@ (rel "stylesheet")
                             (href "/css/main.css")
                             ))
                    (link (@ (rel "me")
                             (href "https://github.com/phoebehfharris")))
                    (link (@ (rel "me")
                             (href "https://www.linkedin.com/in/phoebe-harris-03754b2b4/")))
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
           )
         #:collection-template
         index
         ))
(site #:title "Phoebe Harris"
      #:domain domain
      #:default-metadata
      '((author . "Phoebe Harris")
        (email  . "root@phoebeharris.xyz"))
      #:readers (list commonmark-reader skribe-reader)
      #:builders (list (blog #:theme haunt-theme)
                       (flat-pages "pages" #:template (theme-layout haunt-theme))
                       ;; (static-page "index" haunt-theme "index.html" index)
                       (static-directory "css")
                       (static-directory "static")
                       ;; for stuff required by web standards to be top-level e.g. favicons
                       (static-directory "toplevel" "/")
                       (atom-feed)
                       (atom-feeds-by-tag)))
