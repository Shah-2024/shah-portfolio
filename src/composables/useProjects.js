import { ref, computed } from 'vue'
import { supabase } from '../lib/supabaseClient'

const _projects = ref([])
const _loading = ref(false)
const _error = ref(null)
let _fetched = false

export function useProjects() {
  async function fetchProjects() {
    if (_fetched) return
    _loading.value = true
    const { data, error } = await supabase
      .from('projects')
      .select('*')
      .eq('visible', true)
      .order('sort_order', { ascending: true })
    if (error) { _error.value = error.message }
    else { _projects.value = data; _fetched = true }
    _loading.value = false
  }
  const all = computed(() => _projects.value)
  const engineering = computed(() => _projects.value.filter(p => p.section === 'engineering'))
  const web = computed(() => _projects.value.filter(p => p.section === 'web'))
  const self = computed(() => _projects.value.filter(p => p.section === 'self'))
  return { all, engineering, web, self, loading: _loading, error: _error, fetchProjects }
}
