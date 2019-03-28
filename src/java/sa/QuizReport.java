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
public class QuizReport {
    private int attempted = 0;
    private int unattempted = 0;
    private int correct = 0;
    private int wrong = 0;

    public int getAttempted() {
        return attempted;
    }

    public int getCorrect() {
        return correct;
    }

    public int getUnattempted() {
        return unattempted;
    }

    public int getWrong() {
        return wrong;
    }
    
    public void attempted_increment(){
        attempted++;
    }
    
    public void unattempted_increment(){
        unattempted++;
    }
    
    public void correct_increment(){
        correct++;
    }
    
    public void wrong_increment(){
        wrong++;
    }
}
