(defvar emacs-root "/home/aja/")

(add-to-list 'load-path "~/emacs")
(load "loadenv")

;; giss a shell dear
(shell)

(add-to-list 'load-path "/opt/local/lib/erlang/lib/tools-2.6.1/emacs/")
(require 'erlang-start)

;; disable toolbar (should be mac only, linux uses .Xresources)
(tool-bar-mode 0)


;; get rid of this by setting custom-file
(custom-set-variables
  ;; custom-set-variables was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(ecb-options-version "2.32")
 '(ecb-tip-of-the-day nil)
 '(jde-mvn-command "/usr/local/maven2/bin/mvn")
 '(jde-mvn-default-compiler-source "1.4")
 '(jde-mvn-default-compiler-target "1.5")
 '(jde-mvn-pom-visible t)
 '(jde-mvn-use-server nil)
 '(nxml-child-indent 4)
 '(vc-follow-symlinks nil))
(custom-set-faces
  ;; custom-set-faces was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 )


;;(add-hook 'write-file-hooks 'nuke-trailing-whitespace)
