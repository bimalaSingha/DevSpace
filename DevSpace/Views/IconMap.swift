//
//  IconMap.swift
//  DevSpace
//
//  Created by K Bimala Singha on 10/02/26.
//


import Foundation


struct IconMapper {
    static func getIconUrl(for repoName: String) -> String {
        // Normalize the repo name (lowercase, remove spaces)
        let normalizedName = repoName.lowercased().replacingOccurrences(of: " ", with: "")
        
        switch normalizedName {
        // Swift Libraries
        case "alamofire":
            return "https://raw.githubusercontent.com/Alamofire/Alamofire/master/alamofire.png"
        case "snapkit":
            return "https://raw.githubusercontent.com/SnapKit/SnapKit/develop/logo.png"
        case "swiftlint":
            return "https://raw.githubusercontent.com/realm/SwiftLint/main/assets/SwiftLint.png"
            
        // JavaScript/React Libraries
        case "react":
            return "https://raw.githubusercontent.com/github/explore/main/topics/react/react.png"
        case "nodejs", "node", "node.js":
            return "https://raw.githubusercontent.com/github/explore/main/topics/nodejs/nodejs.png"
        case "express":
            return "https://raw.githubusercontent.com/github/explore/main/topics/express/express.png"
        case "nextjs", "next.js":
            return "https://raw.githubusercontent.com/vercel/next.js/canary/docs/public/nextjs-logo.png"
        case "typescript":
            return "https://raw.githubusercontent.com/github/explore/main/topics/typescript/typescript.png"
            
        // Python Libraries
        case "django":
            return "https://static.djangoproject.com/img/logos/django-logo-negative.png"
        case "flask":
            return "https://raw.githubusercontent.com/github/explore/main/topics/flask/flask.png"
        case "numpy":
            return "https://raw.githubusercontent.com/numpy/numpy/main/branding/logo/primary/numpylogo.png"
        case "pandas":
            return "https://raw.githubusercontent.com/pandas-dev/pandas/main/web/pandas/static/img/pandas_mark.svg"
        case "tensorflow":
            return "https://raw.githubusercontent.com/github/explore/main/topics/tensorflow/tensorflow.png"
            
        // Java Libraries
        case "spring", "springboot", "spring-boot":
            return "https://raw.githubusercontent.com/github/explore/main/topics/spring-boot/spring-boot.png"
    
        case "maven":
            return "https://raw.githubusercontent.com/github/explore/main/topics/maven/maven.png"
        case "gradle":
            return "https://raw.githubusercontent.com/github/explore/main/topics/gradle/gradle.png"
            
        // Generic fallbacks based on language detection
        default:
            return "https://raw.githubusercontent.com/github/explore/main/topics/github/github.png"
        }
    }
    
    // Fallback method using GitHub's topics images
    static func getGenericIconForLanguage(_ language: String) -> String {
        switch language.lowercased() {
        case "swift":
            return "https://raw.githubusercontent.com/github/explore/main/topics/swift/swift.png"
        case "javascript":
            return "https://raw.githubusercontent.com/github/explore/main/topics/javascript/javascript.png"
        case "python":
            return "https://raw.githubusercontent.com/github/explore/main/topics/python/python.png"
        case "java":
            return "https://raw.githubusercontent.com/github/explore/main/topics/java/java.png"
        default:
            return "https://raw.githubusercontent.com/github/explore/main/topics/github/github.png"
        }
    }
}
