extends Node

# project.godot'daki layer sırası ile birebir eşleşmeli:
# Layer 1 → world
# Layer 2 → player
# Layer 3 → enemies
# Layer 4 → player_bullets
# Layer 5 → enemy_bullets

const WORLD          : int = 1        # bit 0
const PLAYER         : int = 2        # bit 1
const ENEMIES        : int = 4        # bit 2
const PLAYER_BULLETS : int = 8        # bit 3
const ENEMY_BULLETS  : int = 16       # bit 4

# Hazır kombinasyonlar (mask olarak kullanılacaklar)
const PLAYER_BULLET_MASK : int = WORLD | ENEMIES   # 5  → player mermisi world ve enemy'e çarpar
const ENEMY_BULLET_MASK  : int = WORLD | PLAYER    # 3  → enemy mermisi world ve player'a çarpar
