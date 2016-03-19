<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>

<!-- Footer -->
<footer>
    <div class="container">
        <div class="row" style="text-align:center">
            <div class="col-lg-12">
                <ul class="list-inline">
                    <li>
                        <a href="javascript:void(0);" id="btnContact2">Contact Email / Support</a>
                    </li>
                </ul>
                <p class="copyright text-muted small">Copyright &copy; ICMS 2016. All Rights Reserved</p>
            </div>
        </div>
    </div>
</footer>
<!-- Modal Contact-->
<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title text-center" id="myModalLabel">Support / Contact</h4>
      </div>
      <div class="modal-body">
            <div class="row text-center">
                <strong>Feel free to contact us!</strong>
            </div>

            <div class="row text-center">
                 <address>
                <br/>Please add the product name, version number, store (Mac App Store or fastspring) and any other relevant information.
                </address>
            </div>
            <div class="row">
                <div class="col-md-2 text-right">
                    <img src="./img/stephane.png">
                </div>
                <div class="col-md-10 text-left">
                <address>
                    <strong>Stéphane (co-founder - developer)</strong><br>
                    <a href="mailto:stephane@sovapps.com">stephane@sovapps.com</a>
                    <p>I develop apps and games on my free time. I’m also a Network & System Ingeneer.</p>
                </address>
                </div>
            </div>
             <div class="row">
                <div class="col-md-2 text-right">
                    <img src="./img/alexandra.png">
                </div>
                <div class="col-md-10 text-left">
                <address>
                    <strong>Alexandra (co-founder - customer support)</strong><br>
                    <a href="mailto:alexandra@sovapps.com">alexandra@sovapps.com</a>
                    <p> I translate the apps and games (Russian/French/English). I also work on app marketing and customer service.</p>
                </address>
                </div>
            </div>
             <div class="row">
                <div class="col-md-2 text-right">
                    <img src="./img/kirby.png">
                </div>
                <div class="col-md-10 text-left">
                <address>
                    <strong>Kirby</strong><br>
                    <p>I sleep, eat and play. Waf.</p>
                </address>
                </div>
            </div>

      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
      </div>
    </div>
  </div>
</div>