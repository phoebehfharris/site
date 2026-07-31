(define-module (index)
  #:use-module (haunt builder blog)
  #:use-module (haunt post)
  #:use-module (haunt site)
  #:export (index))

;; HACK: I want the ugly theme collection template ;P
(define ugly-default-collection-template
  (@@ (haunt builder blog) ugly-default-collection-template))

;; Should be a collection template
;; See https://files.dthompson.us/docs/haunt/latest/Blog.html
;; HAHA this is really stupid!!
(define cv-url "/static/cv.pdf")
(define (index site title posts prefix)
  `((p "I'm Phoebe, a UK-based Computer Science student and embedded programmer.
        I enjoy a lot of different technical interests but I'm primarily into systems programming.
        In particular, I have experience in Rust, C programming, OS development, high-performance computing, embedded software.
        I'm on Committee as Technical Events Officer for my University's Computer Science Society, which is my second consecutive year to do so. ")
    (p "I'm very passionate about open-source software, and i'm basically angling for a job in either the linux world,
or in solutions that bring software that respects people into normal people's hands.
if this sounds like you, " (a (@ (href ,cv-url)) "hire me") ".")
    (p "Outside of software, I'm interested in the humanities, urbanism, martial arts, and fashion. ")
    ,(ugly-default-collection-template site title posts prefix)))
