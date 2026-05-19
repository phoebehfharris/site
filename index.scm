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
(define (index site title posts prefix)
  `((p "Hello! I'm Phoebe. I'm a third-year CS Student currently at the University of Bristol.
I enjoy a lot of different technical interests but I'm primarily into systems programming.
In particular, I have experience in Rust, C programming, OS development, high-performance computing, and computer graphics.
I'm on Committee as Technical Events Officer for my University's Computer Science Society, which is my second consecutive year to do so. ")
    ;; TODO Make hire me a resume link
    (p "I'm very passionate about open-source software, and I'm basically angling for a job in either the Linux world,
or in solutions that bring software that respects people into normal people's hands.
If this sounds like you, hire me. ")
    (p "Outside of software, I'm really into politics, economics, philosophy, and the humanities in general. I'm a big reader, and I'm moderately interested in martial arts, urbanism, and fashion. ")
    ,(ugly-default-collection-template site title posts prefix)))
