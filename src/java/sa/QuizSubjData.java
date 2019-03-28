/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package sa;

/**
 *
 * @author Shreyash Agrawal
 */
public class QuizSubjData {
    private int subj_unattempted;
    private int subj_attempted;
    private int subj_corrected;
    private int subj_incorrect;

    public int getSubj_unattempted() {
            return subj_unattempted;
    }

        public void setSubj_unattempted(int subj_unattempted) {
            this.subj_unattempted = subj_unattempted;
        }

        public int getSubj_attempted() {
            return subj_attempted;
        }

        public void setSubj_attempted(int subj_attempted) {
            this.subj_attempted = subj_attempted;
        }

        public int getSubj_corrected() {
            return subj_corrected;
        }

        public void setSubj_corrected(int subj_corrected) {
            this.subj_corrected = subj_corrected;
        }

        public int getSubj_incorrect() {
            return subj_incorrect;
        }

        public void setSubj_incorrect(int subj_incorrect) {
            this.subj_incorrect = subj_incorrect;
        }
}
