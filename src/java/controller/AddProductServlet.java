/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dao.CategoryDAO;
import dao.ProductDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import java.io.File;
import java.nio.file.Paths;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.Category;
import model.Product;

/**
 *
 * @author VU QUANG DUC - CE181221
 */
@MultipartConfig(
        fileSizeThreshold = 1024 * 1024 * 2, // 2MB
        maxFileSize = 1024 * 1024 * 10, // 10MB
        maxRequestSize = 1024 * 1024 * 50 // 50MB
)
public class AddProductServlet extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try ( PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet AddProductServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet AddProductServlet at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
//        processRequest(request, response);
        int cateid = Integer.parseInt(request.getParameter("cateid"));

        ProductDAO menuDAO = new ProductDAO();
        List<Category> listC = CategoryDAO.getAll();
        request.setAttribute("listCate", listC);

        List<Product> list = menuDAO.getProductByCateID(cateid);
        request.setAttribute("listProducts", list);
        request.getRequestDispatcher("menu.jsp").forward(request, response);

    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
//        processRequest(request, response);
        String productName = request.getParameter("productName").trim();
        String productDescription = request.getParameter("productDescription").trim();
        double productPrice = Double.parseDouble(request.getParameter("productPrice").trim());
        int productQuantity = Integer.parseInt(request.getParameter("productQuantity").trim());
        int cateID = Integer.parseInt(request.getParameter("cateID").trim());

        ProductDAO productDAO = new ProductDAO();
        List<Product> listProduct = productDAO.getAllProduct();      

        for (Product p : listProduct) {
            if (p.getProductName().equalsIgnoreCase(productName)) {
                List<Category> listCate = CategoryDAO.getAll();
                request.setAttribute("productExist", true);
                request.setAttribute("listP", listProduct);
                request.setAttribute("listC", listCate);
                request.getRequestDispatcher("managementProduct.jsp").forward(request, response);
                return;
            }
        }

        Part filePart = request.getPart("productURL"); // Lấy file từ form
        String fileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString(); // Lấy tên file

        // Lấy đường dẫn của dự án và lưu vào trong img/menu/
        String applicationPath = getServletContext().getRealPath("");
        String uploadPath = applicationPath.replace("build\\", "") + "img\\menu";
        
        System.out.println("IMG: " + uploadPath);

        File uploadDir = new File(uploadPath);
        if (!uploadDir.exists()) {
            uploadDir.mkdirs(); // Tạo thư mục nếu chưa tồn tại
        }

        // Tiến hành lưu file
        filePart.write(uploadPath + File.separator + fileName);

        // Trả về URL của file đã upload
        String fileURL = "./img/menu/" + fileName;

        Product product = new Product(0, productName, productDescription, productPrice, productQuantity, fileURL, cateID, null, null);
        boolean isAdd = false;

        try {
            isAdd = productDAO.addProduct(product);
            if (isAdd) {
                response.sendRedirect("productManagement");
            }
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(UpdateProductServlet.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
