/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author Truong Van Khang - CE181852
 */
public class ShippingMethod {

    private String shipID;
    private String methodName;

    public ShippingMethod(String shipID, String methodName) {
        this.shipID = shipID;
        this.methodName = methodName;
    }

    public String getShipID() {
        return shipID;
    }

    public void setShipID(String shipID) {
        this.shipID = shipID;
    }

    public String getMethodName() {
        return methodName;
    }

    public void setMethodName(String methodName) {
        this.methodName = methodName;
    }
    
    

   
    

}
