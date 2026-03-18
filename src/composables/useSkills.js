import { ref } from 'vue'
import { supabase } from '../lib/supabaseClient'

const _skillGroups = ref([])
let _fetched = false

export function useSkills() {
  async function fetchSkills() {
    if (_fetched) return
    const { data } = await supabase.from('skill_groups').select('*').order('sort_order')
    if (data) { _skillGroups.value = data; _fetched = true }
  }
  return { skillGroups: _skillGroups, fetchSkills }
}
