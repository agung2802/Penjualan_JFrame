/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.mycompany.penjualan_barang;

import java.sql.DriverManager;
import java.sql.SQLException;

/**
 *
 * @author Ritz
 */
public class Koneksi {
    
    private static java.sql.Connection koneksi;
    
    public static java.sql.Connection getKoneksi(){
        if(koneksi == null){
            try{
                String url = "jdbc:mysql://localhost:3306/penjualan";
                String user = "root";
                String password = "agung";
                DriverManager.registerDriver(new com.mysql.jdbc.Driver());
                koneksi = DriverManager.getConnection(url, user, password);
            }catch(SQLException t){
                System.out.println("Error Membuat Koneksi");
            } 
        }
        return koneksi;
    }

}
