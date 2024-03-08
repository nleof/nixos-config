{
  programs.wofi = {
    enable = true;
    settings = {
      show = "drun";
      allow_images = true;
      image_size = 30;
      stylesheet = "ef-light.css";
      term = "alacritty";
      insensitive = true;
      key_expand = "Tab";
      no_actions = true;
    };
    style = ''
      * {
        color: #232323;
        font-family: "Iosevka";
      }

      window {
        background-color: #fcffff;
      }

      #entry:nth-child(odd) {
        background-color: #fcf0f0;
      }

      #entry:nth-child(even) {
        background-color: #fcffff;
      }

      #entry:selected {
        background-color: #d4eaf3;
      }

      #entry image {
        margin-right: 12px;
      }

      #input {
        background-color: #fcffff;
        border: none;
      }

      #input:focus {
        box-shadow: none;
      }

      #outer-box {
        border: 1px solid #93a1a1;
      }
    '';
  };
}
