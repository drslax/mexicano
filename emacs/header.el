; **************************************************************************** ;
;                                                                              ;
;                                                         :::      ::::::::    ;
;    header.el                                          :+:      :+:    :+:    ;
;                                                     +:+ +:+         +:+      ;
;    By: abiri <kerneloverseer@protonmail>          +#+  +:+       +#+         ;
;                                                 +#+#+#+#+#+   +#+            ;
;    Created: 2018/12/02 19:02:51 by abiri             #+#    #+#              ;
;    Updated: 2018/12/02 19:03:39 by abiri            ###   ########.fr        ;
;                                                                              ;
; **************************************************************************** ;

(defun complete (s)
	(concat s (make-string (- 50 (length s)) ? ))
)

(defun write_header ()
	(interactive)
	(insert "/* ************************************************************************** */\n")
	(insert "/*                                                                            */\n")
	(insert "/*                                                        :::      ::::::::   */\n")
	(insert (complete (concat "/*   " (file-name-nondirectory buffer-file-name))) "      :+:      :+:    :+:   */\n")
	(insert "/*                                                    +:+ +:+         +:+     */\n")
	(insert (complete (concat "/*   By: " (getenv "USER") " <" (getenv "MAIL") ">")) "  +#+  +:+       +#+        */\n")
	(insert "/*                                                +#+#+#+#+#+   +#+           */\n")
	(insert (complete (concat "/*   Created: " (format-time-string "%Y/%m/%d %H:%M:%S") " by " (getenv "USER"))) "     #+#    #+#             */\n")
	(insert (complete (concat "/*   Updated: " (format-time-string "%Y/%m/%d %H:%M:%S") " by " (getenv "USER"))) "    ###   ########.fr       */\n")
	(insert "/*                                                                            */\n")
	(insert "/* ************************************************************************** */\n")
)

(defun header_is_valid ()
	(interactive)
	(push-mark)
	(goto-char (point-min))
	(setq lines (split-string (buffer-string) "\n"))
	(and
		(eq 80 (length (nth 0 lines)))
		(eq 80 (length (nth 1 lines)))
		(eq 80 (length (nth 2 lines)))
		(eq 80 (length (nth 3 lines)))
		(eq 80 (length (nth 4 lines)))
		(eq 80 (length (nth 5 lines)))
		(eq 80 (length (nth 6 lines)))
		(eq 80 (length (nth 7 lines)))
		(eq 80 (length (nth 8 lines)))
		(eq 80 (length (nth 9 lines)))
		(eq 80 (length (nth 10 lines)))
		(string= (nth 0 lines) "/* ************************************************************************** */")
		(string= (nth 1 lines) "/*                                                                            */")
		(string= (nth 2 lines) "/*                                                        :::      ::::::::   */")
		(string-match (regexp-quote "/\*   ") (nth 3 lines))
		(string-match (regexp-quote ":+:      :+:    :+:   \*/") (nth 3 lines))
		(string= (nth 4 lines) "/*                                                    +:+ +:+         +:+     */")
		(string-match (regexp-quote "+#+  +:+       +#+        \*/") (nth 5 lines))
		(string= (nth 6 lines) "/*                                                +#+#+#+#+#+   +#+           */")
		(string-match (regexp-quote "#+#    #+#             \*/") (nth 7 lines))
		(string-match (regexp-quote "###   ########.fr       \*/") (nth 8 lines))
		(string= (nth 9 lines) "/*                                                                            */")
		(string= (nth 10 lines) "/* ************************************************************************** */")
	)
)

(defun header ()
	(interactive)
	(push-mark)
	(goto-char (point-min))
	(if (not (eq t (header_is_valid)))
		(write_header)
	)
)

(defun update_header ()
	(interactive)
	(if (not (eq t (header_is_valid)))
		(goto-char (point-min))
		(setq lines2 (split-string (buffer-string) "\n"))
		(kill-line 11)
		(insert (nth 0 lines2) "\n")
		(insert (nth 1 lines2) "\n")
		(insert (nth 2 lines2) "\n")
		(insert (nth 3 lines2) "\n")
		(insert (nth 4 lines2) "\n")
		(insert (nth 5 lines2) "\n")
		(insert (nth 6 lines2) "\n")
		(insert (nth 7 lines2) "\n")
	(insert (complete (concat "/*   Updated: " (format-time-string "%Y/%m/%d %H:%M:%S") " by " (getenv "USER"))) "    ###   ########.fr       */\n")
		(insert (nth 9 lines2) "\n")
		(insert (nth 10 lines2) "\n")
	)
)

(global-set-key (kbd "C-x s") 'update_header)
(global-set-key (kbd "C-c h") 'header)
