<template>
  <header class="navbar" :class="{ scrolled: isScrolled }">
    <div class="nav-inner container">
      <RouterLink to="/" class="nav-brand">Shah Tahmid</RouterLink>
      <nav class="nav-links hide-mobile">
        <RouterLink to="/" :class="{ active: $route.name === 'home' }">Home</RouterLink>
        <RouterLink to="/projects">Projects</RouterLink>
        <RouterLink to="/about">About</RouterLink>
        <RouterLink to="/contact">Contact</RouterLink>
      </nav>
      <button class="nav-menu-btn hide-desktop" @click="menuOpen = !menuOpen" aria-label="Menu">
        <span></span><span></span>
      </button>
    </div>
    <!-- Mobile menu -->
    <div class="mobile-menu" :class="{ open: menuOpen }">
      <RouterLink to="/"        @click="menuOpen = false">Home</RouterLink>
      <RouterLink to="/projects" @click="menuOpen = false">Projects</RouterLink>
      <RouterLink to="/about"   @click="menuOpen = false">About</RouterLink>
      <RouterLink to="/contact" @click="menuOpen = false">Contact</RouterLink>
    </div>
  </header>
  <div class="nav-spacer"></div>
</template>

<script setup>
import { ref, onMounted, onUnmounted } from 'vue'
import { RouterLink } from 'vue-router'

const isScrolled = ref(false)
const menuOpen = ref(false)

function onScroll() { isScrolled.value = window.scrollY > 20 }
onMounted(() => window.addEventListener('scroll', onScroll))
onUnmounted(() => window.removeEventListener('scroll', onScroll))
</script>

<style scoped>
.navbar {
  position: fixed;
  top: 0; left: 0; right: 0;
  z-index: 100;
  background: var(--bg);
  border-bottom: 1px solid transparent;
  transition: border-color 0.3s;
}
.navbar.scrolled { border-color: var(--border); }

.nav-inner {
  height: var(--nav-h);
  display: flex;
  align-items: center;
  justify-content: space-between;
}

.nav-brand {
  font-family: var(--font-display);
  font-size: 1.15rem;
  font-weight: 500;
  letter-spacing: 0.02em;
  color: var(--text);
  text-decoration: none;
}

.nav-links {
  display: flex;
  gap: 2.5rem;
}
.nav-links a {
  font-family: var(--font-body);
  font-size: 0.8rem;
  font-weight: 400;
  letter-spacing: 0.1em;
  text-transform: uppercase;
  color: var(--text-3);
  text-decoration: none;
  transition: color 0.2s;
}
.nav-links a:hover,
.nav-links a.active { color: var(--text); }

.nav-menu-btn {
  background: none; border: none; cursor: pointer;
  display: flex; flex-direction: column; gap: 5px; padding: 4px;
}
.nav-menu-btn span {
  display: block; width: 22px; height: 1.5px;
  background: var(--text); transition: all 0.2s;
}

.mobile-menu {
  display: none;
  flex-direction: column;
  padding: 1rem var(--pad) 1.5rem;
  border-top: 1px solid var(--border);
  background: var(--bg);
}
.mobile-menu.open { display: flex; }
.mobile-menu a {
  font-family: var(--font-body);
  font-size: 0.9rem;
  letter-spacing: 0.08em;
  text-transform: uppercase;
  color: var(--text-2);
  text-decoration: none;
  padding: 0.7rem 0;
  border-bottom: 1px solid var(--border);
}
.mobile-menu a:last-child { border-bottom: none; }

.nav-spacer { height: var(--nav-h); }

.hide-desktop { display: none; }
@media (max-width: 768px) {
  .hide-mobile  { display: none; }
  .hide-desktop { display: flex; }
}
</style>
