;; Time-stamp: <2017-02-12 16:50:38 csraghunandan>

;; origami: better folding package than hs-minor-mode
;; https://github.com/gregsexton/origami.el
(use-package origami
  :config
  (global-origami-mode)

  (bind-key "C-c h o"
            (defhydra hydra-origami (:color red
                                            :hint nil)
"
_t_: toggle    _r_: redo    _p_: prev        _c_: close all
_u_: undo      _n_: next    _o_: open all    _q_: quit
"
              ("t" origami-recursively-toggle-node)
              ("u" origami-undo)
              ("r" origami-redo)
              ("p" origami-previous-fold)
              ("n" origami-next-fold)
              ("o" origami-open-all-nodes)
              ("c" origami-close-all-nodes)
              ("q" nil :color blue))))

(provide 'setup-origami)
