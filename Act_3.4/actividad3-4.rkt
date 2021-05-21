;;; Problems

;;; 1.- No funciona el regex
;;; 2.- Modificar write-file function para que
;;; -> Empieze a escribir en la ultima linea del documento
;;; -> Pueda escribir correctamente una lista de listas

#lang racket

; Indicate the functions available in this script
(provide main)

;;; Write to file function

(define (write-file out-file-path data)
  (call-with-output-file out-file-path
    #:exists 'truncate
    (lambda (out)
      (let loop
        ([lst data])
        (cond
          [(not (empty? lst))
             (displayln (car lst) out)
             (loop (cdr lst))])))))


;;;  Read file function 

(define (read-file in-file-path)
  (call-with-input-file in-file-path
    (lambda (in)
      (let loop
        ([line (read-line in)]
         [result empty])
        (if (eof-object? line)
            result
            (loop (read-line in) (append result (list line))))))))


(define (apply_regex lst)
(let loop
    ([lst lst] [result empty])
    (if (empty? lst)
        result
    (loop
        (cdr lst)
        (append result (regexp-match #px"(?>-?(?>0|[1-9]\\d*)(?>\\.\\d+)?(?>[E|e]-?(?>-?(?>0|[1-9]\\d*)(?>\\.\\d+)?))?)"
    (car lst)))
    ))))



(define (main in-file-path out-file-path)
    
    ;;; Escribir el boiler plate de html

    (define open_html (list 
    "<!DOCTYPE html>" 
    "<html lang=\"en\">" 
    "<head>" 
    "    <meta charset=\"UTF-8\">" 
    "    <meta http-equiv=\"X-UA-Compatible\" content=\"IE=edge\">" 
    "    <meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\">" 
    "    <title>Document</title>" 
    "    <style>" 
    "        .number{ color: red; display: inline; }" 
    "        .key{ color: green; display: inline; }" 
    "        .string{ color: orange; display: inline; }" 
    "    </style>" 
    "</head>"
    "<body>"))

    ;;; Leer el json

    (define data (read-file in-file-path))
    (println data)
    ;;; Aplicar regex

    (define json (apply_regex data))
    (println json)
    ;;; Iterar la lista de elementos de json y crear su partes html

    (define json_html (list 
    "{"
    "<br>"
    "<p class=\"key\"> \"hola\" </p>"
    "<br>"
    "}"
    ))

    ;;; Escribir closing tags

    (define close_html (list
    "</body>"
    "</html>"))

    ;;; Generate file in a list

    (define complete_file (list open_html json_html close_html))
    (write-file out-file-path complete_file)
    )


(main "text.txt" "new_text.txt")

