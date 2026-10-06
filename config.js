/* =========================================================
   Content Workspace settings
   - Leave supabaseUrl / supabaseAnonKey empty = demo mode
     (data stays in one browser, not shared with the team)
   - The publishable/anon key is safe to put on a web page:
     access is controlled by RLS rules in the database.
   NEVER put a secret / service_role key in this file.
   ========================================================= */
window.WORKSPACE_CONFIG = {
  supabaseUrl: "https://bdrfaeyztoszimqrdcuj.supabase.co",
  supabaseAnonKey: "sb_publishable_A5aXGj_b2w57rNa7d0byWw_g5Cmqhm_",

  // Brands and their colours (add / remove freely)
  brandColors: {
    BN:     "#d59b2a",
    EOC:    "#4d8ad5",
    PTL:    "#9b6bd6",
    PUREE:  "#d96587",
    GIVING: "#4b9b70",
    SKIN:   "#6c79cf"
  },

  platforms: ["Facebook", "Instagram", "TikTok", "YouTube", "LINE", "X"],

  // Workflow order. Briefing / Designing / Revision count as "In progress".
  statuses: ["Briefing", "Designing", "Revision", "Approved", "Scheduled", "Published"],

  contentTypes: ["Static", "Carousel", "Reels", "TikTok", "Story", "Video"]
};
