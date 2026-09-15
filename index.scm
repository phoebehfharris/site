(define-module (index)
  #:use-module (haunt builder blog)
  #:use-module (haunt post)
  #:use-module (haunt site)
  #:use-module (utils)
  #:export (index))

;; HACK: I want the ugly theme collection template ;P
(define ugly-default-collection-template
  (@@ (haunt builder blog) ugly-default-collection-template))

;; Should be a collection template
;; See https://files.dthompson.us/docs/haunt/latest/Blog.html
;; HAHA this is really stupid!!
(define cv-url "static/cv.pdf")
(define (index site title posts prefix)
  `((p "I'm Phoebe, a UK-based Computer Science student and embedded programmer.
        I'm currently entering my fourth year studying Computer Science at the University of Bristol,
        in which I will be studying cryptology, advanced computer architecture, low-level security,
        programming language theory, and possibly local-first computing.")
    (p "I enjoy a lot of different technical interests but I'm primarily into systems programming.
        In particular, I have experience in Rust, C programming, OS development, high-performance computing, and embedded software.
        I'm on Committee as Technical Events Officer for my University's Computer Science Society, which is my second consecutive year to do so. ")
    (p "I'm very passionate about open-source software, and i'm basically angling for a job in either the Linux world,
        or in solutions that bring software that respects people into normal people's hands.
        if this sounds like you, " ,(anchor "hire me" cv-url "view my CV (PDF)") ".")
    (p "Outside of software, I'm interested in the humanities, urbanism, martial arts, and fashion. I speak a little German.")
    (nav
     (@ (class "links") (aria-label "Links"))
     (ul (li ,(icon-link "phoebehfharris" "https://github.com/phoebehfharris" "github.svg" "GitHub Profile"))
         (li ,(icon-link "phoebeharris:fedora.im" "matrix:u/phoebeharris:fedora.im" "matrix.svg" "Matrix"))
         (li ,(icon-link "hello@phoebeharris.xyz" "mailto:hello@phoebeharris.xyz" "email.svg" "Email"))
         (li ,(icon-link "phoebe-hf-harris" "https://www.linkedin.com/in/phoebe-hf-harris/" "linkedin.svg" "LinkedIn Profile"))
         (li ,(icon-link "GPG key" "static/gpg.txt" "key.svg" "GPG key"))))

    ,(ugly-default-collection-template site title posts prefix)))
