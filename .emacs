(add-to-list 'load-path "~/.emacs.d/el-get/el-get")

(unless (require 'el-get nil 'noerror)
  (with-current-buffer
      (url-retrieve-synchronously
       "https://raw.githubusercontent.com/dimitri/el-get/master/el-get-install.el")
    (goto-char (point-max))
    (eval-print-last-sexp)))

(add-to-list 'el-get-recipe-path "~/.emacs.d/el-get-user/recipes")


(setq my-packages
      (append
       '(color-theme smex auto-complete  yasnippet lua-mode ace-jump-mode flycheck flyspell  projectile switch-window undo-tree)

       (mapcar 'el-get-as-symbol (mapcar 'el-get-source-name el-get-sources))))

(el-get 'sync my-packages)

(require 'projectile)
(require 'ido)
    (ido-mode t)

(load-theme 'manoj-dark)

(global-set-key [(meta x)] (lambda ()
                             (interactive)
                             (or (boundp 'smex-cache)
                                 (smex-initialize))
                             (global-set-key [(meta x)] 'smex)
                             (smex)))

(global-set-key [(shift meta x)] (lambda ()
                                   (interactive)
                                   (or (boundp 'smex-cache)
                                       (smex-initialize))
                                   (global-set-key [(shift meta x)] 'smex-major-mode-commands)
                                   (smex-major-mode-commands)))


 

(autoload
  'acos  "ace-jump-mode"
  "Emacs quick move minor mode"
  t)
;; you can select the key you prefer tools
(define-key global-map (kbd "C-c SPC") 'ace-jump-mode)

(projectile-global-mode)

(require 'switch-window)
(global-set-key (kbd "C-x o") 'switch-window)
(global-set-key (kbd "C-x 1") 'switch-window-then-maximize)
(global-set-key (kbd "C-x 2") 'switch-window-then-split-below)
(global-set-key (kbd "C-x 3") 'switch-window-then-split-right)
(global-set-key (kbd "C-x 0") 'switch-window-then-delete)

(require 'auto-complete-config)
(add-to-list 'ac-dictionary-directories "~/.emacs.d/plugins/auto-complete/ac-dict")
(ac-config-default)
(setq ac-use-quick-help nil)
(setq ac-auto-start 2) ;;	
(setq ac-auto-show-menu 0)
(setq ac-use-menu-map t)
(define-key ac-menu-map "\C-n" 'ac-next)
(define-key ac-menu-map "\C-p" 'ac-previous)
;; menu
(setq ac-menu-height 5)

