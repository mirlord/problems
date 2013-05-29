;; ---------------------------------------------------------------------------
;; Copyright (c) 2013 Vladimir Chizhov <master@mirlord.com>
;; This work is licensed under WTFPL v.2 license.
;; See LICENSE and README for details.
;; ---------------------------------------------------------------------------

(ns staircases)

(defn ^Long ncols
  [^Integer bricks ^Integer columns ^Long return]
  (if (<= bricks 0)
    return
    (if (== columns 1)
      (+ return 1)
      (ncols (- bricks columns)
             columns
             (ncols (- bricks columns)
                    (- columns 1)
                    return)))))

(defn ^Integer max-cols
  [^Integer bricks]
  (+ (Math/round (Math/sqrt (* bricks 2))) 1))

(defn ^Long solve
  [^Integer bricks]
  (apply +
         (map #(ncols bricks % 0)
              (range 2 (max-cols bricks)))))

(defn -main
  [& args]
    (let [bricks (nth args 0)]
      (if bricks
        (println (solve (read-string bricks)))
        (println (solve (read-string (read-line)))))))

