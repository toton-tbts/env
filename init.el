(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-faces-vector
   [default default default italic underline success warning error])
 '(ansi-color-names-vector
   ["#2e3436" "#a40000" "#4e9a06" "#c4a000" "#204a87" "#5c3566" "#729fcf" "#eeeeec"])
 '(custom-enabled-themes '(wombat))
 '(line-number-mode nil)
 '(org-agenda-files
   '("c:/Users/NDA04/OneDrive/ドキュメント/note/Udemy/11_【続】Microsoft Power BI Desktop - 入門講座 ～DAX-CALCULATE特訓編～/note.org" "c:/Users/NDA04/OneDrive/ドキュメント/note/Udemy/7_Power_BI_A-Z/note.org"))
 '(package-selected-packages '(company helm)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

(define-key key-translation-map (kbd "C-h") (kbd "<DEL>"))
(define-key key-translation-map (kbd "M-h") (kbd "<C-backspace>"))
(define-key key-translation-map (kbd "C-?") (kbd "C-h"))
(define-key key-translation-map (kbd "M-?") (kbd "M-h"))
;; 12.17
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; Ctrl-x p で逆向きへのウィンドウ移動
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(global-set-key "\C-xp" (lambda () (interactive) (other-window -1)))

(setq default-directory "c:/Users/NDA04/OneDrive/ドキュメント")

(prefer-coding-system 'utf-8)

;; skk
(setq load-path (cons "c:/emacs-27.1-x86_64/share/emacs/site-lisp/skk" load-path))
(setq Info-default-directory-list
      (cons "c:/emacs-27.1-x86_64/share/info" Info-default-directory-list))
(require 'skk-autoloads)

;; 起動時の Emacsロゴなどのメッセージを出さない
(setq inhibit-startup-message t)

;; *scratch* バッファの初期メッセージを消す
(setq initial-scratch-message "")

(tool-bar-mode -1)
(menu-bar-mode -1)
(scroll-bar-mode -1)

(electric-pair-mode 1)

(setq ring-bell-function 'ignore)

(setq-default tab-width 2 indent-tabs-mode nil)

(set-cursor-color "aquamarine")

;; 12.16
;; https://emacs-jp.github.io/packages/package
;; https://qiita.com/achiwa912/items/dd4338b9d11d0b9919e1
(require 'package)

;; package-archivesを上書き
(setq package-archives
      '(;; ("melpa" . "https://melpa.org/packages/")
        ("melpa-stable" . "https://stable.melpa.org/packages/")
        ("org" . "https://orgmode.org/elpa/")
        ("gnu" . "https://elpa.gnu.org/packages/")))

;; 初期化
(package-initialize)

;; https://qiita.com/kod314/items/3a31719db27a166d2ec1
;; https://qiita.com/blue0513/items/c0dc35a880170997c3f5
(with-eval-after-load 'company
      ;; (setq company-auto-expand t) ;; 1個目を自動的に補完
      (setq company-transformers '(company-sort-by-backend-importance)) ;; ソート順
      (setq company-idle-delay 0) ; 遅延なしにすぐ表示
      (setq company-minimum-prefix-length 2) ; デフォルトは4
      (setq company-selection-wrap-around t) ; 候補の最後の次は先頭に戻る
      (setq completion-ignore-case t)
      (setq company-dabbrev-downcase nil)
      (global-set-key (kbd "C-M-i") 'company-complete)
      ;; C-n, C-pで補完候補を次/前の候補を選択
      (define-key company-active-map (kbd "C-n") 'company-select-next)
      (define-key company-active-map (kbd "C-p") 'company-select-previous)
      (define-key company-active-map (kbd "C-i") 'company-complete-selection) ;; TABで候補を設定
      (define-key company-active-map [tab] 'company-complete-selection) ;; TABで候補を設定
      (define-key company-active-map (kbd "C-h") nil) ;; C-hはバックスペース割当のため無効化
      (define-key company-active-map (kbd "C-S-h") 'company-show-doc-buffer) ;; ドキュメント表示はC-Shift-h

      ;; ;; 未選択項目
      ;; (set-face-attribute 'company-tooltip nil
      ;;             :foreground "#36c6b0" :background "#244f36")
      ;; ;; 未選択項目&一致文字
      ;; (set-face-attribute 'company-tooltip-common nil
      ;;               :foreground "white" :background "#244f36")
      ;; ;; 選択項目
      ;; (set-face-attribute 'company-tooltip-selection nil
      ;;             :foreground "#a1ffcd" :background "#007771")
      ;; ;; 選択項目&一致文字
      ;; (set-face-attribute 'company-tooltip-common-selection nil
      ;;               :foreground "white" :background "#007771")
      ;; ;; スクロールバー
      ;; (set-face-attribute 'company-scrollbar-fg nil
      ;;             :background "#4cd0c1")
      ;; ;; スクロールバー背景
      ;; (set-face-attribute 'company-scrollbar-bg nil
      ;;             :background "#002b37")
      )

;; helm
;; https://qiita.com/jabberwocky0139/items/86df1d3108e147c69e2c
(require 'helm)
(require 'helm-config)

;; The default "C-x c" is quite close to "C-x C-c", which quits Emacs.
;; Changed to "C-c h". Note: We must set "C-c h" globally, because we
;; cannot change `helm-command-prefix-key' once `helm-config' is loaded.
(global-set-key (kbd "C-c h") 'helm-command-prefix)
(global-unset-key (kbd "C-x c"))

(define-key helm-map (kbd "<tab>") 'helm-execute-persistent-action) ; rebind tab to run persistent action
(define-key helm-map (kbd "C-i") 'helm-execute-persistent-action) ; make TAB work in terminal
(define-key helm-map (kbd "C-z")  'helm-select-action) ; list actions using C-z

(when (executable-find "curl")
  (setq helm-google-suggest-use-curl-p t))

(setq helm-split-window-in-side-p           t ; open helm buffer inside current window, not occupy whole other window
      helm-move-to-line-cycle-in-source     t ; move to end or beginning of source when reaching top or bottom of source.
      helm-ff-search-library-in-sexp        t ; search for library in `require' and `declare-function' sexp.
      helm-scroll-amount                    8 ; scroll 8 lines other window using M-<next>/M-<prior>
      helm-ff-file-name-history-use-recentf t
      helm-echo-input-in-header-line t)

;; (defun spacemacs//helm-hide-minibuffer-maybe ()
;;   "Hide minibuffer in Helm session if we use the header line as input field."
;;   (when (with-helm-buffer helm-echo-input-in-header-line)
;;     (let ((ov (make-overlay (point-min) (point-max) nil nil t)))
;;       (overlay-put ov 'window (selected-window))
;;       (overlay-put ov 'face
;;                    (let ((bg-color (face-background 'default nil)))
;;                      `(:background ,bg-color :foreground ,bg-color)))
;;       (setq-local cursor-type nil))))


;; (add-hook 'helm-minibuffer-set-up-hook
;;           'spacemacs//helm-hide-minibuffer-maybe)

(setq helm-autoresize-max-height 0)
(setq helm-autoresize-min-height 20)
(helm-autoresize-mode 1)

(helm-mode 1)

(global-set-key (kbd "M-x") 'helm-M-x)
(setq helm-M-x-fuzzy-match t) ;; optional fuzzy matching for helm-M-x
(global-set-key (kbd "M-y") 'helm-show-kill-ring)
(global-set-key (kbd "C-x b") 'helm-mini)
(setq helm-buffers-fuzzy-matching t
      helm-recentf-fuzzy-match    t)
(global-set-key (kbd "C-x C-f") 'helm-find-files)
(setq helm-semantic-fuzzy-match t
      helm-imenu-fuzzy-match    t)
(setq helm-locate-fuzzy-match t)
(global-set-key (kbd "C-c h o") 'helm-occur)
(setq helm-apropos-fuzzy-match t)
(setq helm-lisp-fuzzy-completion t)

;; ;; 12.17
;; ;; python
;; ;; 上手く動作しないの
;; ;; https://org-technology.com/posts/emacs-elpy.html
;; ;;; Elpy を有効化
;; (elpy-enable)
;; ;;; 使用する Anaconda の仮想環境を設定
;; ;; (defvar venv-default "~/anaconda3/envs/base")
;; (defvar venv-default "c:/Users/NDA04/anaconda3/envs/pwsw")
;; ;;; virtualenv を使っているなら次のようなパス
;; ;; (defvar venv-default "~/.virtualenvs/hoge")
;; ;;; デフォルト環境を有効化
;; (pyvenv-activate venv-default)
;; ;;; REPL 環境に IPython を使う
;; ;; (elpy-use-ipython)
;; ;;; 自動補完のバックエンドとして Rope か Jedi を選択
;; (setq elpy-rpc-backend "jedi")
