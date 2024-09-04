<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!-- ======= Sidebar ======= -->
<aside id="sidebar" class="sidebar">
    <ul class="sidebar-nav" id="sidebar-nav">
        
        <!-- 신고 관리 -->
        <li class="nav-item report">
            <a class="nav-link collapsed" data-bs-target="#complaint-nav" data-bs-toggle="collapse" href="#">
                <i class="bi bi-menu-button-wide"></i><span>신고 관리</span><i class="bi bi-chevron-down ms-auto"></i>
            </a>
            <ul id="complaint-nav" class="nav-content" data-bs-parent="#sidebar-nav">
                <li class="report-handler"><a href="/admin/report"><i class="bi bi-circle"></i><span>신고 처리</span></a></li>
                <li class="report-details"><a href="/admin/process"><i class="bi bi-circle"></i><span>처리 내역</span></a></li>
            </ul>
        </li>
        <!-- End 신고 관리 -->

        <!-- 메타버스 관리 -->
        <li class="nav-item metaverse">
            <a class="nav-link collapsed" data-bs-target="#metaverse-nav" data-bs-toggle="collapse" href="#" area-expanded="true">
                <i class="bi bi-journal-text"></i><span>유저 관리</span><i class="bi bi-chevron-down ms-auto"></i>
            </a>
            <ul id="metaverse-nav" class="nav-content collapse" data-bs-parent="#sidebar-nav">
                <li><a href="/admin/user"><i class="bi bi-circle"></i><span>관리자 권한</span></a></li>
            </ul>
        </li>
        <!-- 유저 관리 -->

        <!-- 광고 관리 -->
<!--         <li class="nav-item advertising"> -->
<!--             <a class="nav-link collapsed" data-bs-target="#advertising-nav" data-bs-toggle="collapse" href="#"> -->
<!--                 <i class="bi bi-layout-text-window-reverse"></i><span>광고 관리</span><i class="bi bi-chevron-down ms-auto"></i> -->
<!--             </a> -->
<!--             <ul id="advertising-nav" class="nav-content collapse" data-bs-parent="#sidebar-nav"> -->
<!--                 <li><a href="advertising-general.html"><i class="bi bi-circle"></i><span>General advertising</span></a></li> -->
<!--             </ul> -->
<!--         </li> -->
        <!-- End 광고 관리 -->

        <!-- 요약 -->
        <li class="nav-item summary">
            <a class="nav-link collapsed" data-bs-target="#report-nav" data-bs-toggle="collapse" href="#">
                <i class="bi bi-bar-chart"></i><span>데이터 요약</span><i class="bi bi-chevron-down ms-auto"></i>
            </a>
            <ul id="report-nav" class="nav-content collapse" data-bs-parent="#sidebar-nav">
                <li class="summary"><a href="/admin/summary"><i class="bi bi-circle"></i><span>요약</span></a></li>
            </ul>
        </li>
        <!-- End 요약 -->

<!--         Pages -->
<!--         <li class="nav-heading">Pages</li> -->
<!--         <li class="nav-item"><a class="nav-link collapsed" href="users-profile.html"><i class="bi bi-person"></i> <span>Profile</span></a></li> -->
<!--         End Pages -->
    </ul>
</aside>
<!-- End Sidebar-->