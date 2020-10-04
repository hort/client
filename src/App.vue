<template>
  <div>
    <nav class="navbar navbar-expand-sm navbar-dark navbar-custom">
      <div class="navbar-header">
        <a class="navbar-brand" href="#">hort</a>
      </div>
      <ul class="navbar-nav">
        <li class="nav-item">
          <a class="nav-link" href="/dashboard">Dashboard</a>
        </li>
        <li class="nav-item">
          <a class="nav-link" href="/services">Services</a>
        </li>
      </ul>
    </nav>
    <router-view/>
  </div>
</template>

<style>
@import './assets/sass/app.scss';
</style>
