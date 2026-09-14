(use-modules (haunt asset)
             (haunt post)
             (haunt site)
             (haunt builder assets)
             (haunt builder atom)
             (haunt builder blog)
             (haunt builder flat-pages)
             (haunt reader)
             (haunt reader commonmark)
             (haunt reader skribe)
             (srfi srfi-19)
             (index)
             (utils))

(define domain "phoebeharris.xyz")

(define haunt-theme
  (theme #:name "Theme"
         #:layout
         (lambda (site title body)
           (define site-title (string-append "Phoebe Harris's site - " title))
           `((doctype "html")
             (html (@ (lang "en-GB"))
                   (head
                    (meta (@ (charset "UTF-8")))
                    (meta (@ (name "viewport") (content "width=device-width, initial-scale=1")))
                    (meta (@ (name "text-scale") (content "scale")))
                    (title ,site-title)

                    (link (@ (rel "stylesheet")
                             (href "/css/main.css")))
                    (link (@ (rel "preload")
                             (type "font/woff2")
                             (as "font")
                             (href "/static/Ubuntu-Regular.woff2")))

                    (meta (@ (property "og:title") (content ,site-title)))
	                (meta (@ (name "description") (content "A personal website for Phoebe Harris")))
	                (meta (@ (property "og:description") (content "A personal website for Phoebe Harris")))

                    (link (@ (rel "icon")
                             (type "image/x-icon")
                             (href "/favicon.ico")))

                    (meta (@ (property "og:site_name") (content "Phoebe Harris's site")))

                    (meta (@ (name "author") (content "Phoebe Harris")))

	                (meta (@ (name "color-scheme") (content "dark light")))
	                (meta (@ (name "theme-color") (content "#eff1f5") (media "prefers-color-scheme: light")))
	                (meta (@ (name "theme-color") (content "#1e1e2e") (media "prefers-color-scheme: dark")))

                    (link (@ (rel "alternate")
		                     (type "application/atom+xml")
		                     (title "Phoebe Harris")
		                     (href "/atom.xml")))
                    (link (@ (rel "me")
                             (href "https://github.com/phoebehfharris")))
                    (link (@ (rel "me")
                             (href "https://www.linkedin.com/in/phoebe-hf-harris"))))
                   (body
                    (a (@ (href "#main") (class "skip-content")) "Skip to main content")
                    (header (@ (class "header"))
                            (nav (@ (aria-label "Header"))
                                 (li ,(anchor "home" "/"))
                                 (li ,(anchor "now" "/now.html"))
                                 (li ,(anchor "projects" "/projects.html"))))
                    (main (@ (id "main") (tabindex "-1")) ,body)))))
         #:post-template
         (lambda (post)
           `((article
              (h1 (@ (class "title")) ,(post-ref post 'title))
              (div (@ (class "date")) ,(date->string (post-date post) "~d ~B, ~Y"))
              (div (@ (class "content")) ,(post-sxml post)))))
         #:collection-template
         index))
(site #:title "Phoebe Harris"
      #:domain domain
      #:default-metadata
      '((author . "Phoebe Harris")
        (email  . "hello@phoebeharris.xyz"))
      #:readers (list commonmark-reader html-reader skribe-reader)
      #:builders (list (blog #:theme haunt-theme)
                       (flat-pages "pages" #:template (theme-layout haunt-theme))
                       ;; (static-page "index" haunt-theme "index.html" index)
                       (static-directory "css")
                       (static-directory "static")
                       ;; for stuff required by web standards to be top-level e.g. favicons
                       (static-directory "toplevel" "/")
                       (atom-feed)
                       (atom-feeds-by-tag)))
