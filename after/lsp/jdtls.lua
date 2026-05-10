local eclipse_jdtls_path = vim.fn.stdpath("data") .. "/mason/packages/jdtls"
local lombok = eclipse_jdtls_path .. "/lombok.jar"
local workspace_dir = vim.fn.stdpath("cache") .. "/jdtls/workspace/" .. vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")

return {
  cmd = {
    eclipse_jdtls_path .. "/bin/jdtls",
    "--jvm-arg=" .. "-javaagent:" .. lombok,
    "-data", workspace_dir
  },
  filetypes = { "java" },
  root_markers = {
    {
      "mvnw",
      "gradlew",
      "settings.gradle",
      "settings.gradle.kts",
      ".git"
    },
    {
      'build.xml',
      'pom.xml',
      'build.gradle',
      'build.gradle.kts'
    }
  },
  settings = {
    java = {
      configuration = {
        runtimes = {
          {
            name = "JavaSE-26",
            path = "/usr/lib/jvm/java-26-openjdk/"
          },
        }
      },
      format = {
        enabled = true,
        -- settings = {
        --   url = home .. "/.local/java/eclipse-java-google-style.xml",
        -- },
      },
      signatureHelp = { enabled = true },
      -- contentProvider = { preferred = "fernflower" }, -- Use fernflower to decompile library code
      completion = {
        favoriteStaticMembers = {
          "org.hamcrest.MatcherAssert.assertThat",
          "org.hamcrest.Matchers.*",
          "org.hamcrest.CoreMatchers.*",
          "org.junit.jupiter.api.Assertions.*",
          "java.util.Objects.requireNonNull",
          "java.util.Objects.requireNonNullElse",
          "org.mockito.Mockito.*",
        },
        filteredTypes = {
          "com.sun.*",
          "io.micrometer.shaded.*",
          "java.awt.*",
          "jdk.*",
          "sun.*",
        },
        -- importOrder = {
        --   "java",
        --   "jakarta",
        --   "javax",
        --   "com",
        --   "org"
        -- }
      },
      sources = {
        organizeImports = {
          starThreshold = 9999,
          staticStarThreshold = 9999,
        },
      },
      codeGeneration = {
        toString = {
          template = "${object.className}{${member.name()}=${member.value}, ${otherMembers}}",
        },
        hashCodeEquals = {
          useJava7Objects = true,
        },
        useBlocks = true,
      },
      telemetry = {
        enabled = false
      }
    }
  }
}
