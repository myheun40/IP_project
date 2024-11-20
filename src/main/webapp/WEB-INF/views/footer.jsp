<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<footer class="footer mt-0">
  <div class="container">
      <div class=>
        <h5>Contact</h5>
        <span>Email: info@example.com</span>
      </div>
      <div>
        <span>&copy; 2024 면접의 고수. All rights reserved.</span>
      </div>
  </div>
</footer>

<style>

  .footer {
    background-color: #333;
    color: white;
    padding: 25px 0;
    position: relative;
    bottom: 0;
    width: 100%;
    font-size:0.8rem;
  }
  .footer h5{
    font-size:1rem;
  }

  .footer .container {
    display: flex;
    justify-content: space-between;
    align-items: flex-end;
    max-width: 1400px;
    margin:0 auto !important;
  }

  /* Responsive Design */
  @media (max-width: 768px) {
    .footer .container {
      flex-direction: column;
      text-align: center;
    }

    .footer-right ul {
      flex-direction: column;
      gap: 10px;
    }
  }

</style>